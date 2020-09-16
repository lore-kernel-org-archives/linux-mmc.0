Return-Path: <SRS0=q7gx=CZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C21C433E2
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Sep 2020 07:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F185E2080C
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Sep 2020 07:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fNnVPdvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgIPHqT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Sep 2020 03:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPHqS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Sep 2020 03:46:18 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A654AC06174A
        for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2020 00:46:17 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z18so944797pfg.0
        for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2020 00:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=YBGqaQ7Mhk39pbTnXIi+xyhZDjqG6D7yXDA2Zk5NuOk=;
        b=fNnVPdvlgD65xX2UEg1tGvdK16fHWLa5Nd42tfy9sUti5Sg14mSUtFwX5FXwSyH+nG
         GnMA57A5Uqc5q3bxhB3j83YvblFWIWlOjgPbAxTwDN4zdw17XQ+fXDo2lHvbqblnaZVZ
         1NlFiEdUFwDgoC842rEtlbSWFcXY1fOKHh+ByLbt+a56NsfGyJ0gfHg5SFwLt5dnCmr4
         2BPOPq6qjCTs8e+EVli+UYDUF1wRd9jD200yzRV4dA+KTW/shSAH7V34esazV/PGg1OC
         ynBaUoyKl7CVWIMdPREQ/hRgRrldST2yyfgMCCLkMXQeru3J8O4EcUlcXguq0SeN4Ske
         64Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=YBGqaQ7Mhk39pbTnXIi+xyhZDjqG6D7yXDA2Zk5NuOk=;
        b=C7JAMoW+KneSoY0X0IkRRU/kytDzv2BzeOz5aqWunyjhmqGx+oh6Up3vYBk4R7IbUP
         A84vVBEkkLs4acNk9o2SWsqpbMTVRcJiBklUCzM4OcpgK+7QY+f4bKTfbV5PME5GuLJy
         oGFj7sm7WRAVU+s4S9aHZYEQvqkom+DSvAU8AGx1pu3bJitdvbVFHvBjxv6sb73IyQke
         lNIPxDSxqQ2+8g5l+QAaVuv4GiS2MWy+zlwZxAgQnDLArNG8mY1BZHaxYDE4Ti7xJGzB
         MMnPItzkC9bEDvu1Jir47b9nD8++BL45+GcSRJSAhV+GxhP7iDA3RNwMKeaPkDMYuJJ6
         ZmTQ==
X-Gm-Message-State: AOAM532eU2sa9oEKq+xJ14je6tDb5oeuqITRYktPINgRgsHs+42rQrw8
        TvOSoapV55GmlqJmEA94Trj9cQ==
X-Google-Smtp-Source: ABdhPJycyrhUihV5cTTqsmGs9Uo4RSf7rHRSbwZkMvxGeJXQbUwb7C8IPdGdNwDkBRmFsOEcI+9A9Q==
X-Received: by 2002:a63:f441:: with SMTP id p1mr7413405pgk.453.1600242377052;
        Wed, 16 Sep 2020 00:46:17 -0700 (PDT)
Received: from laputa (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id q16sm16782125pfj.117.2020.09.16.00.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 00:46:16 -0700 (PDT)
Date:   Wed, 16 Sep 2020 16:46:12 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH V3 15/21] mmc: sdhci: UHS-II support, modify
 set_power() to handle vdd2
Message-ID: <20200916074612.GA2977734@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20200710111140.29725-1-benchuanggli@gmail.com>
 <97c43596-a18f-4c7a-c226-5209772d91d1@intel.com>
 <20200914054537.GA2738017@laputa>
 <f0ff6c0a-4029-72a9-559c-8930ef0ea8bb@intel.com>
 <20200915062443.GB2860208@laputa>
 <0c11a3cb-fe7c-978d-7608-c98453899b5f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c11a3cb-fe7c-978d-7608-c98453899b5f@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Adrian,

On Wed, Sep 16, 2020 at 09:42:28AM +0300, Adrian Hunter wrote:
> On 15/09/20 9:24 am, AKASHI Takahiro wrote:
> > Adrain,
> > 
> > On Mon, Sep 14, 2020 at 09:36:02AM +0300, Adrian Hunter wrote:
> >> On 14/09/20 8:45 am, AKASHI Takahiro wrote:
> >>> Adrian,
> >>>
> >>> On Fri, Aug 21, 2020 at 05:11:18PM +0300, Adrian Hunter wrote:
> >>>> On 10/07/20 2:11 pm, Ben Chuang wrote:
> >>>>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>>>>
> >>>>> VDD2 is used for powering UHS-II interface.
> >>>>> Modify sdhci_set_power_and_bus_voltage(), sdhci_set_power_noreg()
> >>>>> and sdhci_set_power_noreg() to handle VDD2.
> >>>>
> >>>> vdd2 is always 1.8 V and I suspect there may never be support for anything
> >>>> else, so we should start with 1.8 V only.
> >>>
> >>> What do you mean here?
> >>> You don't want to add an extra argument, vdd2, to sdhci_set_power().
> >>> Correct?
> >>
> >> Yes
> >>
> >>>
> >>>> Also can we create uhs2_set_power_reg() and uhs2_set_power_noreg() and use
> >>>> the existing ->set_power() callback
> >>>
> >>> Again what do you expect here?
> >>>
> >>> Do you want to see any platform-specific mmc driver who supports UHS-II
> >>> to implement its own call back like:
> >>
> >> Not exactly.  I expect there to be a common implementation in sdhci-uhs2.c
> >> called sdhci_uhs2_set_power() for example, that drivers can use by setting
> >> their .set_power = sdhci_uhs2_set_power.  If they need platform-specific
> >> code as well then their platform-specific code can call
> >> sdhci_uhs2_set_power() if desired.
> >>
> >>>
> >>> void sdhci_foo_set_power(struct sdhci_host *host, unsigned char mode,
> >>>                                   unsigned short vdd)
> >>> {
> >>>         sdhci_set_power(host, mode,vdd);
> >>>
> >>>         /* in case that sdhci_uhs2 module is not inserted */
> >>>         if (!(mmc->caps & MMC_CAP_UHS2))
> >>>                 return;
> >>>
> >>>         /* vdd2 specific operation */
> >>>         if (IS_ERR_OR_NULL(host->mmc->supply.vmmc2))
> >>>                 sdhci_uhs2_set_power_noreg(host, mode);
> >>>         else
> >>>                 sdhci_uhs2_set_power_reg(host, mode);
> >>>
> >>>         /* maybe more platform-specific initialization */
> >>> }
> >>>
> >>> struct sdhci_ops sdhci_foo_ops = {
> >>>         .set_power = sdhci_foo_set_power,
> >>>         ...
> >>> }
> > 
> > What do you think about this logic in general?
> > (If necessary, read it replacing "foo" to "uhs2".)
> > 
> > What I'm concerned about is SDHCI_POWER_CONTROL register.
> > Vdd and vdd2 are controlled with corresponding bits in this register.
> > It seems to be "natural" to me that vdd and vdd2 are enabled
> > in a single function rather than putting them in separate ones.
> > 
> > In particular, in the case of sdhci_set_power_noreg(), there exist a couple
> > of "quirks" around writing the bits to SDHCI_POWER_CONTROL register.
> 
> We can treat UHS-II support as being for new hardware and therefore
> we don't necessarily need to support old quirks.  Just make sure if
> a quirk is not being supported, to add a comment to that effect.
> 
> > I don't know how we should handle them if we have a separate function,
> > say, sdhci_uhs2_set_power_noreg().
> > Do you want to see a copy of the same logic in sdhci_uhs2_set_power_noreg()? 
> 
> I would probably consider making another function that non-UHS-II
> drivers do not need to care about e.g. existing drivers can keep using
> sdhci_set_power_noreg() and sdhci_uhs2 can call __sdhci_set_power_noreg()

Well, but


> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 592a55a34b58..ffe54f06fe38 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2013,8 +2013,8 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
>  		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
>  }
>  
> -void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
> -			   unsigned short vdd)
> +void __sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
> +			   unsigned short vdd, u8 vdd2)
>  {
>  	u8 pwr = 0;
>  
> @@ -2048,7 +2048,7 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  	if (host->pwr == pwr)
>  		return;
>  
> -	host->pwr = pwr;
> +	host->pwr = pwr | vdd2;

(the line above is wrong, but anyway)

we must also set
        if (vdd2)
                pwr |= SDHCI_VDD2_POWER_ON;

As a result, this new function is the almost exact same as the corresponding one
in our v3 patch, except its name.

Now do you allow such a small piece of UHS-II specific code to be
placed in sdhci.c?

-Takahiro Akashi


>  	if (pwr == 0) {
>  		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> @@ -2085,6 +2085,13 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  			mdelay(10);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(__sdhci_set_power_noreg);
> +
> +void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
> +			   unsigned short vdd)
> +{
> +	__sdhci_set_power_noreg(host, mode, vdd, 0);
> +}
>  EXPORT_SYMBOL_GPL(sdhci_set_power_noreg);
>  
>  void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
> 
> > 
> > -Takahiro Akashi
> > 
> > 
> >>>
> >>> Is this what you mean?
> >>> (I'm not quite sure yet that sdhci_ush2_set_power_noreg() can be split off
> >>> from sdhci_set_power_noreg().)
> >>>
> >>> -Takahiro Akashi
> 
