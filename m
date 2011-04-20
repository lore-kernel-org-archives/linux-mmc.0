From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] mmc: mxs-mmc: add support for pre_req and post_req
Date: Wed, 20 Apr 2011 16:17:00 +0800
Message-ID: <20110420081700.GA1517@S2100-06.ap.freescale.net>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
 <1303058010-30256-1-git-send-email-shawn.guo@linaro.org>
 <BANLkTikGEUj-J2kOcd3gjVAtGhm+88DJKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:20296 "EHLO
	TX2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab1DTINH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 04:13:07 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikGEUj-J2kOcd3gjVAtGhm+88DJKQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, cjb@laptop.org

On Wed, Apr 20, 2011 at 09:58:48AM +0200, Per Forlin wrote:
> > =A0static struct dma_async_tx_descriptor *mxs_mmc_prep_dma(
> > =A0 =A0 =A0 =A0struct mxs_mmc_host *host, unsigned int append)
> > =A0{
> > @@ -312,8 +342,8 @@ static struct dma_async_tx_descriptor *mxs_mmc_=
prep_dma(
> >
> > =A0 =A0 =A0 =A0if (data) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* data */
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_map_sg(mmc_dev(host->mmc), data->=
sg,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->sg_len, =
host->dma_dir);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mxs_mmc_prep_dma_data(host, data,=
 NULL))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sgl =3D data->sg;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sg_len =3D data->sg_len;
> > =A0 =A0 =A0 =A0} else {
> > @@ -328,9 +358,11 @@ static struct dma_async_tx_descriptor *mxs_mmc=
_prep_dma(
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0desc->callback =3D mxs_mmc_dma_irq_c=
allback;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0desc->callback_param =3D host;
> > =A0 =A0 =A0 =A0} else {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_unmap_sg(mmc_dev=
(host->mmc), data->sg,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 data->sg_len, host->dma_dir);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->host_cookie =3D=
 0;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> When is dma_unmap_sg called? If host_cookie is set dma_unmap() should
> only be called from post_req.
> My guess is
> + if (data && !data->host_cookie) {
> It looks like only dma_map is run in parallel with transfer but not
> dma_unmap. This may explain the numbers.

Good catch.  I forgot patching mxs_mmc_request_done where dma_unmap_sg
is called.  Will correct and retest ...

--=20
Regards,
Shawn

