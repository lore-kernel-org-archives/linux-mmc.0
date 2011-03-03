From: <subhashj@codeaurora.org>
Subject: RE: [PATCH 02/12] mmc: sd: add support for signal voltage switch procedure
Date: Fri, 4 Mar 2011 02:38:28 +0530
Message-ID: <000001cbd9e7$26b044b0$7410ce10$@org>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com> <1297762510-2696-3-git-send-email-arindam.nath@amd.com> <000301cbd82a$19ef2480$4dcd6d80$@org> <6C03668EAF45B747AF947A1603D1B300E35EF3F4@SAUSEXMBP01.amd.com> <000001cbd9a5$2be1a330$83a4e990$@org> <6C03668EAF45B747AF947A1603D1B300E3788351@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:63702 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758799Ab1CCVId (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Mar 2011 16:08:33 -0500
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300E3788351@SAUSEXMBP01.amd.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "'Nath, Arindam'" <Arindam.Nath@amd.com>, cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, "'Su, Henry'" <Henry.Su@amd.com>, "'Lu, Aaron'" <Aaron.Lu@amd.com>, anath.amd@gmail.com


> -----Original Message-----
> From: Nath, Arindam [mailto:Arindam.Nath@amd.com]
> Sent: Thursday, March 03, 2011 7:05 PM
> To: subhashj@codeaurora.org; cjb@laptop.org
> Cc: linux-mmc@vger.kernel.org; Su, Henry; Lu, Aaron;
> anath.amd@gmail.com
> Subject: RE: [PATCH 02/12] mmc: sd: add support for signal voltage
> switch procedure
> 
> Hi Subhash,
> 
> > -----Original Message-----
> > From: subhashj@codeaurora.org [mailto:subhashj@codeaurora.org]
> > Sent: Thursday, March 03, 2011 6:46 PM
> > To: Nath, Arindam; cjb@laptop.org
> > Cc: linux-mmc@vger.kernel.org; Su, Henry; Lu, Aaron;
> > anath.amd@gmail.com
> > Subject: RE: [PATCH 02/12] mmc: sd: add support for signal voltage
> > switch procedure
> >
> >
> >
> > > -----Original Message-----
> > > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > > owner@vger.kernel.org] On Behalf Of Nath, Arindam
> > > Sent: Wednesday, March 02, 2011 1:36 PM
> > > To: subhashj@codeaurora.org; cjb@laptop.org
> > > Cc: linux-mmc@vger.kernel.org; Su, Henry; Lu, Aaron;
> > > anath.amd@gmail.com
> > > Subject: RE: [PATCH 02/12] mmc: sd: add support for signal voltage
> > > switch procedure
> > >
> > > Hi Subhash,
> > >
> > >
> > > > -----Original Message-----
> > > > From: subhashj@codeaurora.org [mailto:subhashj@codeaurora.org]
> > > > Sent: Tuesday, March 01, 2011 9:33 PM
> > > > To: Nath, Arindam; cjb@laptop.org
> > > > Cc: linux-mmc@vger.kernel.org; Su, Henry; Lu, Aaron;
> > > > anath.amd@gmail.com
> > > > Subject: RE: [PATCH 02/12] mmc: sd: add support for signal
> voltage
> > > > switch procedure
> > > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > > > > owner@vger.kernel.org] On Behalf Of Arindam Nath
> > > > > Sent: Tuesday, February 15, 2011 3:05 PM
> > > > > To: cjb@laptop.org
> > > > > Cc: linux-mmc@vger.kernel.org; henry.su@amd.com;
> > aaron.lu@amd.com;
> > > > > anath.amd@gmail.com; Arindam Nath
> > > > > Subject: [PATCH 02/12] mmc: sd: add support for signal voltage
> > > switch
> > > > > procedure
> > > > >
> > > > > Host Controller v3.00 adds another Capabilities register. We
> can
> > > > > directly read this register without any version checking since
> > the
> > > > > new register bits will be considred as reserved in older
> > > controllers,
> > > > > and will be read as 0. Apart from other things, this new
> register
> > > > > indicates whether the Host Controller supports SDR50, SDR104,
> and
> > > > > DDR50 UHS-I modes. So depending on the host support, we set
> > > > > the corresponding MMC_CAP_* flags. One more new register. Host
> > > > Control2
> > > > > is added in v3.00, which is used during Signal Voltage Switch
> > > > prcedure
> > > > > described below.
> > > > >
> > > > > Since as per v3.00 spec, UHS-I supported hosts should set S18R
> to
> > > 1,
> > > > > we set S18R (bit 24) of OCR before sending ACMD41. We also need
> > to
> > > > set
> > > > > XPC (bit 28) of OCR in case the host can supply >150mA. This
> > > support
> > > > is
> > > > > indicated by the Maximum Current Capabilities register of the
> > Host
> > > > > Controller.
> > > > >
> > > > > If the response of ACMD41 has both CCS and S18A set, we start
> the
> > > > > signal voltage switch procedure, which if successfull, will
> > switch
> > > > > the card from 3.3V signalling to 1.8V signalling. Signal
> voltage
> > > > > switch procedure adds support for a new command CMD11 in the
> > > Physical
> > > > > Layer Spec v3.01. As part of this procedure, we need to set
> 1.8V
> > > > > Signalling
> > > > > Enable (bit 3) of Host Control2 register, which if remains set
> > > after
> > > > > 5ms,
> > > > > means the switch to 1.8V signalling is successfull. Otherwise,
> we
> > > > clear
> > > > > bit 24 of OCR and retry the initialization sequence.
> > > > >
> > > > > Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> > > > > ---
> > > > >  drivers/mmc/core/sd.c     |   37 ++++++++++-
> > > > >  drivers/mmc/core/sd_ops.c |   25 ++++++++
> > > > >  drivers/mmc/core/sd_ops.h |    1 +
> > > > >  drivers/mmc/host/sdhci.c  |  147
> > > > > +++++++++++++++++++++++++++++++++++++++++----
> > > > >  drivers/mmc/host/sdhci.h  |   18 +++++-
> > > > >  include/linux/mmc/host.h  |    8 +++
> > > > >  include/linux/mmc/sd.h    |    1 +
> > > > >  7 files changed, 219 insertions(+), 18 deletions(-)
> > > > >
> > > > > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > > > > index b3f8a3c..e968d5c 100644
> > > > > --- a/drivers/mmc/core/sd.c
> > > > > +++ b/drivers/mmc/core/sd.c
> > > > > @@ -408,6 +408,7 @@ struct device_type sd_type = {
> > > > >  int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid)
> > > > >  {
> > > > >     int err;
> > > > > +   u32 rocr;
> > > > >
> > > > >     /*
> > > > >      * Since we're changing the OCR value, we seem to
> > > > > @@ -427,10 +428,25 @@ int mmc_sd_get_cid(struct mmc_host *host,
> > u32
> > > > > ocr, u32 *cid)
> > > > >     if (!err)
> > > > >             ocr |= 1 << 30;
> > > > >
> > > > > -   err = mmc_send_app_op_cond(host, ocr, NULL);
> > > > > +   /* If the host can supply more than 150mA, XPC should be
> set
> > to
> > > > > 1. */
> > > > > +   if (host->caps & (MMC_CAP_SET_XPC_330 | MMC_CAP_SET_XPC_300
> |
> > > > > +       MMC_CAP_SET_XPC_180))
> > > > > +           ocr |= 1 << 28;
> > > > > +
> > > >
> > > > Why do you need MMC_CAP_SET_XPC_300 here? MMC_CAP_SET_XPC_330 &
> > > > MMC_CAP_SET_XPC_180 is not enough?
> > >
> > > According to the Host Controller Spec v3.00, section 2.2.26:
> > >
> > > "If a Host System can afford more than 150mA, Host Driver set XPC
> to
> > > 1."
> > >
> > > Now since >150mA can be set for 1.8V, 3.0V and 3.3V, the above
> > > condition checks for all these cases.
> > >
> >
> > 3.0v and 3.3v is part of High voltage range supported by card (2.7v-
> > 3.3v).
> > Now if host supports any voltage from this range with 150ma driver
> > strength
> > then I think only config say MMC_CAP_SET_XPC_HV (high voltage) should
> > be set
> > by
> > host and then only one check required here. Does it make sense?
> 
> You have a valid point here. But I kept the configs *XPC_300 and
> *XPC_330 separate so that in future if someone wants to base his/her
> code on either of the flags being set, but not both, they can easily do
> so. If you still think it is a good idea to have a common *CAP for both
> of them, please let me know. I will modify the code accordingly.
> 

Ok. it's fine. you keep them as 2 separate caps.

Thanks,
Subhash
	
> Thanks,
> Arindam


