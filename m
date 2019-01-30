From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 05/11] mmc: s3cmci: handle highmem pages
Date: Wed, 30 Jan 2019 08:57:47 +0100
Message-ID: <CAPDyKFpcHv7KwuVpWcKjxj--n4YOFADWD5WzOCJ6Dca_JjqnAw@mail.gmail.com>
References: <20190114095804.27978-1-hch@lst.de> <20190114095804.27978-6-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114095804.27978-6-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ben Dooks <ben-linux@fluff.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 14 Jan 2019 at 10:58, Christoph Hellwig <hch@lst.de> wrote:
>
> Instead of setting up a kernel pointer to track the current PIO address,
> track the offset in the current page, and do an atomic kmap for the page
> while doing the actual PIO operations.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nitpick: This one have some trailing whitespace errors, which git
complains about when I apply it.

No need to re-spin due to this, I can fix it  up.

Kind regards
Uffe

> ---
>  drivers/mmc/host/s3cmci.c | 107 +++++++++++++++++++-------------------
>  drivers/mmc/host/s3cmci.h |   3 +-
>  2 files changed, 55 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index 10f5219b3b40..1be84426c817 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -15,6 +15,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/clk.h>
> +#include <linux/highmem.h>
>  #include <linux/mmc/host.h>
>  #include <linux/platform_device.h>
>  #include <linux/cpufreq.h>
> @@ -317,26 +318,17 @@ static void s3cmci_check_sdio_irq(struct s3cmci_host *host)
>         }
>  }
>
> -static inline int get_data_buffer(struct s3cmci_host *host,
> -                                 u32 *bytes, u32 **pointer)
> +static inline int get_data_buffer(struct s3cmci_host *host)
>  {
> -       struct scatterlist *sg;
> -
> -       if (host->pio_active == XFER_NONE)
> -               return -EINVAL;
> -
> -       if ((!host->mrq) || (!host->mrq->data))
> -               return -EINVAL;
> -
>         if (host->pio_sgptr >= host->mrq->data->sg_len) {
>                 dbg(host, dbg_debug, "no more buffers (%i/%i)\n",
>                       host->pio_sgptr, host->mrq->data->sg_len);
>                 return -EBUSY;
>         }
> -       sg = &host->mrq->data->sg[host->pio_sgptr];
> +       host->cur_sg = &host->mrq->data->sg[host->pio_sgptr];
>
> -       *bytes = sg->length;
> -       *pointer = sg_virt(sg);
> +       host->pio_bytes = host->cur_sg->length;
> +       host->pio_offset = host->cur_sg->offset;
>
>         host->pio_sgptr++;
>
> @@ -422,11 +414,16 @@ static void s3cmci_disable_irq(struct s3cmci_host *host, bool transfer)
>
>  static void do_pio_read(struct s3cmci_host *host)
>  {
> -       int res;
>         u32 fifo;
>         u32 *ptr;
>         u32 fifo_words;
>         void __iomem *from_ptr;
> +       void *buf;
> +
> +       if (host->pio_active == XFER_NONE)
> +               goto done;
> +       if (!host->mrq || !host->mrq->data)
> +               goto done;
>
>         /* write real prescaler to host, it might be set slow to fix */
>         writel(host->prescaler, host->base + S3C2410_SDIPRE);
> @@ -435,20 +432,12 @@ static void do_pio_read(struct s3cmci_host *host)
>
>         while ((fifo = fifo_count(host))) {
>                 if (!host->pio_bytes) {
> -                       res = get_data_buffer(host, &host->pio_bytes,
> -                                             &host->pio_ptr);
> -                       if (res) {
> -                               host->pio_active = XFER_NONE;
> -                               host->complete_what = COMPLETION_FINALIZE;
> -
> -                               dbg(host, dbg_pio, "pio_read(): "
> -                                   "complete (no more data).\n");
> -                               return;
> -                       }
> +                       if (get_data_buffer(host) < 0)
> +                               goto done;
>
>                         dbg(host, dbg_pio,
> -                           "pio_read(): new target: [%i]@[%p]\n",
> -                           host->pio_bytes, host->pio_ptr);
> +                           "pio_read(): new target: [%i]@[%zu]\n",
> +                           host->pio_bytes, host->pio_offset);
>                 }
>
>                 dbg(host, dbg_pio,
> @@ -470,63 +459,65 @@ static void do_pio_read(struct s3cmci_host *host)
>                 host->pio_count += fifo;
>
>                 fifo_words = fifo >> 2;
> -               ptr = host->pio_ptr;
> -               while (fifo_words--)
> +
> +               buf = (kmap_atomic(sg_page(host->cur_sg)) + host->pio_offset);
> +               ptr = buf;
> +               while (fifo_words--) {
>                         *ptr++ = readl(from_ptr);
> -               host->pio_ptr = ptr;
> +                       host->pio_offset += 4;
> +               }
>
>                 if (fifo & 3) {
>                         u32 n = fifo & 3;
>                         u32 data = readl(from_ptr);
> -                       u8 *p = (u8 *)host->pio_ptr;
> +                       u8 *p = (u8 *)ptr;
>
>                         while (n--) {
>                                 *p++ = data;
>                                 data >>= 8;
> +                               host->pio_offset++;
>                         }
>                 }
> +               kunmap_atomic(buf);
>         }
>
>         if (!host->pio_bytes) {
> -               res = get_data_buffer(host, &host->pio_bytes, &host->pio_ptr);
> -               if (res) {
> -                       dbg(host, dbg_pio,
> -                           "pio_read(): complete (no more buffers).\n");
> -                       host->pio_active = XFER_NONE;
> -                       host->complete_what = COMPLETION_FINALIZE;
> -
> -                       return;
> -               }
> +               if (get_data_buffer(host) < 0)
> +                       goto done;
>         }
>
>         enable_imask(host,
>                      S3C2410_SDIIMSK_RXFIFOHALF | S3C2410_SDIIMSK_RXFIFOLAST);
> +       return;
> +
> +done:
> +       host->pio_active = XFER_NONE;
> +       host->complete_what = COMPLETION_FINALIZE;
> +       dbg(host, dbg_pio, "pio_read(): complete (no more data).\n");
>  }
>
>  static void do_pio_write(struct s3cmci_host *host)
>  {
>         void __iomem *to_ptr;
> -       int res;
> +       void *buf;
>         u32 fifo;
>         u32 *ptr;
>
> +       if (host->pio_active == XFER_NONE)
> +               goto done;
> +       if (!host->mrq || !host->mrq->data)
> +               goto done;
> +
>         to_ptr = host->base + host->sdidata;
>
>         while ((fifo = fifo_free(host)) > 3) {
>                 if (!host->pio_bytes) {
> -                       res = get_data_buffer(host, &host->pio_bytes,
> -                                                       &host->pio_ptr);
> -                       if (res) {
> -                               dbg(host, dbg_pio,
> -                                   "pio_write(): complete (no more data).\n");
> -                               host->pio_active = XFER_NONE;
> -
> -                               return;
> -                       }
> +                       if (get_data_buffer(host) < 0)
> +                               goto done;
>
>                         dbg(host, dbg_pio,
> -                           "pio_write(): new source: [%i]@[%p]\n",
> -                           host->pio_bytes, host->pio_ptr);
> +                           "pio_write(): new source: [%i]@[%zd]\n",
> +                           host->pio_bytes, host->pio_offset);
>
>                 }
>
> @@ -543,13 +534,20 @@ static void do_pio_write(struct s3cmci_host *host)
>                 host->pio_count += fifo;
>
>                 fifo = (fifo + 3) >> 2;
> -               ptr = host->pio_ptr;
> -               while (fifo--)
> +               buf = (kmap_atomic(sg_page(host->cur_sg)) + host->pio_offset);
> +               ptr = buf;
> +               while (fifo--) {
>                         writel(*ptr++, to_ptr);
> -               host->pio_ptr = ptr;
> +                       host->pio_offset += 4;
> +               }
> +               kunmap_atomic(buf);
>         }
>
>         enable_imask(host, S3C2410_SDIIMSK_TXFIFOHALF);
> +       return;
> +done:
> +       dbg(host, dbg_pio, "pio_write(): complete (no more data).\n");
> +       host->pio_active = XFER_NONE;
>  }
>
>  static void pio_tasklet(unsigned long data)
> @@ -1055,6 +1053,7 @@ static int s3cmci_prepare_pio(struct s3cmci_host *host, struct mmc_data *data)
>         BUG_ON((data->flags & BOTH_DIR) == BOTH_DIR);
>
>         host->pio_sgptr = 0;
> +       host->cur_sg = &host->mrq->data->sg[host->pio_sgptr];
>         host->pio_bytes = 0;
>         host->pio_count = 0;
>         host->pio_active = rw ? XFER_WRITE : XFER_READ;
> diff --git a/drivers/mmc/host/s3cmci.h b/drivers/mmc/host/s3cmci.h
> index 30c2c0dd1bc8..4320f7d832dc 100644
> --- a/drivers/mmc/host/s3cmci.h
> +++ b/drivers/mmc/host/s3cmci.h
> @@ -50,10 +50,11 @@ struct s3cmci_host {
>
>         int                     dma_complete;
>
> +       struct scatterlist      *cur_sg;
>         u32                     pio_sgptr;
>         u32                     pio_bytes;
>         u32                     pio_count;
> -       u32                     *pio_ptr;
> +       u32                     pio_offset;
>  #define XFER_NONE 0
>  #define XFER_READ 1
>  #define XFER_WRITE 2
> --
> 2.20.1
>
