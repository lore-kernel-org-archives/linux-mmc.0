From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v3] dmaengine: add new dma API for max_segment_number
Date: Thu, 16 Jun 2011 11:54:01 +0200
Message-ID: <BANLkTikSj+9-p3uvDTbSYF1nX3sxvbDwUQ@mail.gmail.com>
References: <BANLkTi=-t9HVc6U6QY07su+c3WztsGoq3Q@mail.gmail.com>
	<1308139721-4008-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1308139721-4008-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, patches@linaro.org, vinod.koul@intel.com, gregkh@suse.de, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Dan Williams <dan.j.williams@intel.com>, cjb@laptop.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 15, 2011 at 2:08 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> [PATCH v3] dmaengine: add new dma API for max_segment_number
The subject "dmaengine:" in this case is a bit misleading since the
patches doesn't touch any code inside drivers/dmaengine.
For this patch I would prefer subject "dma-mapping:"

There is a need for the DMA clients to be able to extract the max seg
number from the DMA provider/device. I think this patch is a sane way
of making this information available.

Regards,
Per

> Like dma_set(get)_max_seg_size for max_segment_size, the patch adds
> max_segment_number into device_dma_parameters and creates the
> corresponding dmaengine API dma_set(get)_max_seg_number for it.
>
> Here is the user story that tells the need of the new api. =A0The
> mxs-mmc is the mmc host controller for Freescale MXS architecture.
> There are a pair of =A0mmc host specific parameters max_seg_size and
> max_segs that mxs-mmc host driver needs to tell mmc core, so that
> mmc core can know how big each data segment could be and how many
> segments could be handled one time in a scatter list by host driver.
>
> The mxs-mmc driver is one user of dmaengine mxs-dma, and it will call
> mxs-dma to transfer data in scatter list. =A0That is to say mxs-mmc has
> no idea of what max_seg_size and max_segs should be, because they are
> all mxs-dma capability parameters, and mxs-mmc needs to query them
> from mxs-dma.
>
> Right now, there is well defined dma api (dma_get_max_seg_size) for
> mmc to query max_seg_size from dma driver, but the one for max_segs
> is missing. =A0That's why mxs-mmc driver has to hard-code it.
>
> The mxs-mmc is just one example to demonstrate the need of the new
> api, and there are other mmc host drivers (mxcmmc on imx-dma is
> another example) and possibly even other dmaengine users need this
> new api to know the maximum segments that dma driver can handle per
> dma call.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> =A0include/linux/device.h =A0 =A0 =A0| =A0 16 ++++++++++++----
> =A0include/linux/dma-mapping.h | =A0 15 +++++++++++++++
> =A02 files changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/device.h b/include/linux/device.h
> index c66111a..f1152c5 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -481,12 +481,20 @@ extern int devres_release_group(struct device *dev,=
 void *id);
> =A0extern void *devm_kzalloc(struct device *dev, size_t size, gfp_t gfp);
> =A0extern void devm_kfree(struct device *dev, void *p);
>
> +/*
> + * device_dma_parameters is a property of DMA provider, and it belongs t=
o the
> + * 'struct device' that actually provides DMA service, typically the dri=
vers
> + * under drivers/dma, although in some cases the DMA provider and block =
device
> + * uses DMA service happen to be the same 'struct device'.
> + *
> + * It's not necessary for every single DMA providers to have this struct=
ure,
> + * because some DMA providers simply do not have these parameters/limita=
tions.
> + * For those do have, the DMA providers should be responsible for settin=
g the
> + * parameters up.
> + */
> =A0struct device_dma_parameters {
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* a low level driver may set these to teach IOMMU code a=
bout
> - =A0 =A0 =A0 =A0* sg limitations.
> - =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0unsigned int max_segment_size;
> + =A0 =A0 =A0 unsigned int max_segment_number;
> =A0 =A0 =A0 =A0unsigned long segment_boundary_mask;
> =A0};
>
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index ba8319a..fd314f4 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -131,6 +131,21 @@ static inline unsigned int dma_set_max_seg_size(stru=
ct device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EIO;
> =A0}
>
> +static inline unsigned int dma_get_max_seg_number(struct device *dev)
> +{
> + =A0 =A0 =A0 return dev->dma_parms ? dev->dma_parms->max_segment_number =
: 1;
> +}
> +
> +static inline unsigned int dma_set_max_seg_number(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int number)
> +{
> + =A0 =A0 =A0 if (dev->dma_parms) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->dma_parms->max_segment_number =3D numb=
er;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> +}
> +
> =A0static inline unsigned long dma_get_seg_boundary(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0return dev->dma_parms ?
> --
> 1.7.4.1
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
