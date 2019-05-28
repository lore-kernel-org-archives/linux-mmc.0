From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: android-goldfish: Drop pointer to mmc_host from goldfish_mmc_host
Date: Tue, 28 May 2019 10:52:39 +0200
Message-ID: <CAPDyKFpbYWdLfecru4+Y9zRrdpnzgwwMmCbqDZUwaXoei5o28Q@mail.gmail.com>
References: <1557258749-29009-1-git-send-email-kamlesh.gurudasani@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1557258749-29009-1-git-send-email-kamlesh.gurudasani@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mike Lockwood <lockwood@android.com>, Christoph Hellwig <hch@lst.de>, "Gustavo A . R . Silva" <garsilva@embeddedor.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, 7 May 2019 at 21:53, Kamlesh Gurudasani
<kamlesh.gurudasani@gmail.com> wrote:
>
> The driver for android-goldfish uses a pointer to get from the private
> goldfish_mmc_host structure to the generic mmc_host structure.
> However the latter is always immediately preceding the former in
> memory, so compute its address with a subtraction (which is cheaper than a
> dereference) and drop the superfluous pointer.
>
> No functional change intended.
>
> Signed-off-by: Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/android-goldfish.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android-goldfish.c
> index 61e4e2a..f6334c2 100644
> --- a/drivers/mmc/host/android-goldfish.c
> +++ b/drivers/mmc/host/android-goldfish.c
> @@ -113,7 +113,6 @@ struct goldfish_mmc_host {
>         struct mmc_request      *mrq;
>         struct mmc_command      *cmd;
>         struct mmc_data         *data;
> -       struct mmc_host         *mmc;
>         struct device           *dev;
>         unsigned char           id; /* 16xx chips have 2 MMC blocks */
>         void                    *virt_base;
> @@ -175,7 +174,7 @@ goldfish_mmc_start_command(struct goldfish_mmc_host *host, struct mmc_command *c
>                 resptype = 3;
>                 break;
>         default:
> -               dev_err(mmc_dev(host->mmc),
> +               dev_err(mmc_dev(mmc_from_priv(host)),
>                         "Invalid response type: %04x\n", mmc_resp_type(cmd));
>                 break;
>         }
> @@ -221,8 +220,8 @@ static void goldfish_mmc_xfer_done(struct goldfish_mmc_host *host,
>                                         data->sg->length);
>                 }
>                 host->data->bytes_xfered += data->sg->length;
> -               dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_len,
> -                            dma_data_dir);
> +               dma_unmap_sg(mmc_dev(mmc_from_priv(host)), data->sg,
> +                            host->sg_len, dma_data_dir);
>         }
>
>         host->data = NULL;
> @@ -236,7 +235,7 @@ static void goldfish_mmc_xfer_done(struct goldfish_mmc_host *host,
>
>         if (!data->stop) {
>                 host->mrq = NULL;
> -               mmc_request_done(host->mmc, data->mrq);
> +               mmc_request_done(mmc_from_priv(host), data->mrq);
>                 return;
>         }
>
> @@ -278,7 +277,7 @@ static void goldfish_mmc_cmd_done(struct goldfish_mmc_host *host,
>
>         if (host->data == NULL || cmd->error) {
>                 host->mrq = NULL;
> -               mmc_request_done(host->mmc, cmd->mrq);
> +               mmc_request_done(mmc_from_priv(host), cmd->mrq);
>         }
>  }
>
> @@ -313,7 +312,7 @@ static irqreturn_t goldfish_mmc_irq(int irq, void *dev_id)
>                 struct mmc_request *mrq = host->mrq;
>                 mrq->cmd->error = -ETIMEDOUT;
>                 host->mrq = NULL;
> -               mmc_request_done(host->mmc, mrq);
> +               mmc_request_done(mmc_from_priv(host), mrq);
>         }
>
>         if (end_command)
> @@ -339,12 +338,13 @@ static irqreturn_t goldfish_mmc_irq(int irq, void *dev_id)
>                 u32 state = GOLDFISH_MMC_READ(host, MMC_STATE);
>                 pr_info("%s: Card detect now %d\n", __func__,
>                         (state & MMC_STATE_INSERTED));
> -               mmc_detect_change(host->mmc, 0);
> +               mmc_detect_change(mmc_from_priv(host), 0);
>         }
>
>         if (!end_command && !end_transfer && !state_changed && !cmd_timeout) {
>                 status = GOLDFISH_MMC_READ(host, MMC_INT_STATUS);
> -               dev_info(mmc_dev(host->mmc),"spurious irq 0x%04x\n", status);
> +               dev_info(mmc_dev(mmc_from_priv(host)), "spurious irq 0x%04x\n",
> +                        status);
>                 if (status != 0) {
>                         GOLDFISH_MMC_WRITE(host, MMC_INT_STATUS, status);
>                         GOLDFISH_MMC_WRITE(host, MMC_INT_ENABLE, 0);
> @@ -383,7 +383,7 @@ static void goldfish_mmc_prepare_data(struct goldfish_mmc_host *host,
>
>         dma_data_dir = mmc_get_dma_dir(data);
>
> -       host->sg_len = dma_map_sg(mmc_dev(host->mmc), data->sg,
> +       host->sg_len = dma_map_sg(mmc_dev(mmc_from_priv(host)), data->sg,
>                                   sg_len, dma_data_dir);
>         host->dma_done = 0;
>         host->dma_in_use = 1;
> @@ -461,7 +461,6 @@ static int goldfish_mmc_probe(struct platform_device *pdev)
>         }
>
>         host = mmc_priv(mmc);
> -       host->mmc = mmc;
>
>         pr_err("mmc: Mapping %lX to %lX\n", (long)res->start, (long)res->end);
>         host->reg_base = ioremap(res->start, resource_size(res));
> @@ -508,8 +507,7 @@ static int goldfish_mmc_probe(struct platform_device *pdev)
>
>         ret = device_create_file(&pdev->dev, &dev_attr_cover_switch);
>         if (ret)
> -               dev_warn(mmc_dev(host->mmc),
> -                        "Unable to create sysfs attributes\n");
> +               dev_warn(mmc_dev(mmc), "Unable to create sysfs attributes\n");
>
>         GOLDFISH_MMC_WRITE(host, MMC_SET_BUFFER, host->phys_base);
>         GOLDFISH_MMC_WRITE(host, MMC_INT_ENABLE,
> @@ -525,7 +523,7 @@ static int goldfish_mmc_probe(struct platform_device *pdev)
>  dma_alloc_failed:
>         iounmap(host->reg_base);
>  ioremap_failed:
> -       mmc_free_host(host->mmc);
> +       mmc_free_host(mmc);
>  err_alloc_host_failed:
>         return ret;
>  }
> @@ -533,14 +531,15 @@ static int goldfish_mmc_probe(struct platform_device *pdev)
>  static int goldfish_mmc_remove(struct platform_device *pdev)
>  {
>         struct goldfish_mmc_host *host = platform_get_drvdata(pdev);
> +       struct mmc_host *mmc = mmc_from_priv(host);
>
>         BUG_ON(host == NULL);
>
> -       mmc_remove_host(host->mmc);
> +       mmc_remove_host(mmc);
>         free_irq(host->irq, host);
>         dma_free_coherent(&pdev->dev, BUFFER_SIZE, host->virt_base, host->phys_base);
>         iounmap(host->reg_base);
> -       mmc_free_host(host->mmc);
> +       mmc_free_host(mmc);
>         return 0;
>  }
>
> --
> 2.7.4
>
