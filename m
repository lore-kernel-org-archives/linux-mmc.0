From: James Hogan <james.hogan@imgtec.com>
Subject: dw_mmc build broken in next-20130220 (was Re: [PATCH v3 2/2]
 lib/scatterlist: use page iterator in the mapping iterator)
Date: Wed, 20 Feb 2013 16:42:31 +0000
Message-ID: <CAAG0J99wUgcOt09_XxuK+ennnuj7OzxcJndYYGXbAqpj59E7PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: Imre Deak <imre.deak@intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Tejun Heo <tj@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, linaro-mm-sig@lists.linaro.org, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-next@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 13 February 2013 15:10, Imre Deak <imre.deak@intel.com> wrote:
> For better code reuse use the newly added page iterator to iterate
> through the pages. The offset, length within the page is still
> calculated by the mapping iterator as well as the actual mapping.
> Idea from Tejun Heo <tj@kernel.org>.
>
> Signed-off-by: Imre Deak <imre.deak@intel.com>
> ---
>  include/linux/scatterlist.h |    6 +++---
>  lib/scatterlist.c           |   46 ++++++++++++++++++++-----------------------
>  2 files changed, 24 insertions(+), 28 deletions(-)
>
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 788a853..a6cd692 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -295,9 +295,9 @@ struct sg_mapping_iter {
>         size_t                  consumed;       /* number of consumed bytes */
>
>         /* these are internal states, keep away */
> -       struct scatterlist      *__sg;          /* current entry */
> -       unsigned int            __nents;        /* nr of remaining entries */
> -       unsigned int            __offset;       /* offset within sg */
> +       unsigned int            __offset;       /* offset within page */
> +       struct sg_page_iter     __piter;        /* page iterator */
> +       unsigned int            __remaining;    /* remaining bytes on page */
>         unsigned int            __flags;
>  };

Hi,

FYI, in next-20130220 this appears to break the build of the dw_mmc driver:
drivers/mmc/host/dw_mmc.c In function 'dw_mci_read_data_pio':
drivers/mmc/host/dw_mmc.c +1457 : error: 'struct sg_mapping_iter' has
no member named '__sg'
drivers/mmc/host/dw_mmc.c In function 'dw_mci_write_data_pio':
drivers/mmc/host/dw_mmc.c +1512 : error: 'struct sg_mapping_iter' has
no member named '__sg'

Cheers
James
