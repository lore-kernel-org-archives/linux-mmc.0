From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 1/3] dmaengine: add new dma API for max_segment_number
Date: Sun, 12 Jun 2011 23:28:20 +0800
Message-ID: <20110612152819.GA29737@S2100-06.ap.freescale.net>
References: <1307345414-26872-1-git-send-email-shawn.guo@linaro.org>
 <BANLkTi=-t9HVc6U6QY07su+c3WztsGoq3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BANLkTi=-t9HVc6U6QY07su+c3WztsGoq3Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, patches@linaro.org, vinod.koul@intel.com, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Jun 07, 2011 at 03:35:51PM -0700, Dan Williams wrote:
> On Mon, Jun 6, 2011 at 12:30 AM, Shawn Guo <shawn.guo@linaro.org> wro=
te:
> > Like dma_set(get)_max_seg_size for max_segment_size, the patch adds
> > max_segment_number into device_dma_parameters and creates the
> > corresponding dmaengine API dma_set(get)_max_seg_number for it.
> >
> > Here is the user story that tells the need of the new api. =A0The
> > mxs-mmc is the mmc host controller for Freescale MXS architecture.
> > There are a pair of =A0mmc host specific parameters max_seg_size an=
d
> > max_segs that mxs-mmc host driver needs to tell mmc core, so that
> > mmc core can know how big each data segment could be and how many
> > segments could be handled one time in a scatter list by host driver=
=2E
> >
> > The mxs-mmc driver is one user of dmaengine mxs-dma, and it will ca=
ll
> > mxs-dma to transfer data in scatter list. =A0That is to say mxs-mmc=
 has
> > no idea of what max_seg_size and max_segs should be, because they a=
re
> > all mxs-dma capability parameters, and mxs-mmc needs to query them
> > from mxs-dma.
> >
> > Right now, there is well defined dma api (dma_get_max_seg_size) for
> > mmc to query max_seg_size from dma driver, but the one for max_segs
> > is missing. =A0That's why mxs-mmc driver has to hard-code it.
> >
> > The mxs-mmc is just one example to demonstrate the need of the new
> > api, and there are other mmc host drivers (mxcmmc on imx-dma is
> > another example) and possibly even other dmaengine users need this
> > new api to know the maximum segments that dma driver can handle per
> > dma call.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> > Changes since v1:
> > =A0* Update commit message to explain why the new api is needed
> >
> > =A0include/linux/device.h =A0 =A0 =A0| =A0 =A01 +
> > =A0include/linux/dma-mapping.h | =A0 15 +++++++++++++++
> > =A02 files changed, 16 insertions(+), 0 deletions(-)
> >
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index c66111a..44cb2528 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -487,6 +487,7 @@ struct device_dma_parameters {
> > =A0 =A0 =A0 =A0 * sg limitations.
> > =A0 =A0 =A0 =A0 */
>=20
> Given the discussion seems like this patch is missing an update to th=
e
> documentation of the struct to clarify the definition of dma provider=
=2E
>  I.e. that this info belongs to the device doing the dma, and that is
> is not necessarily the same as the device that is requesting dma
> service.
>=20
What about the following?

/*
 * device_dma_parameters is a property of DMA provider, and it belongs =
to the
 * 'struct device' that actually provides DMA service, typically the dr=
ivers
 * under drivers/dma, although in some cases the DMA provider and block=
 device
 * uses DMA service happen to be the same 'struct device'.
 *
 * It's not necessary for every single DMA providers to have this struc=
ture,
 * because some DMA providers simply do not have these parameters/limit=
ations.
 * For those do have, the DMA providers should be responsible for setti=
ng the
 * parameters up.
 */
struct device_dma_parameters {
        unsigned int max_segment_size;
        unsigned int max_segment_number;
        unsigned long segment_boundary_mask;
};

--=20
Regards,
Shawn
