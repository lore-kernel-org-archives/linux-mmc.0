From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [PATCH v3 01/10] mmc: sdhci-st: Intial support for ST SDHCI
 controller
Date: Wed, 9 Jul 2014 13:59:34 +0100
Message-ID: <20140709125934.GA18634@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1401899424-1365-1-git-send-email-peter.griffin@linaro.org>
 <1401899424-1365-2-git-send-email-peter.griffin@linaro.org>
 <CAPDyKFoFNaFpDTVvMF3fbkrgYwUY1_hcbic89JyJzezFDRtN_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:40353 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbaGIM7j (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Jul 2014 08:59:39 -0400
Received: by mail-wi0-f180.google.com with SMTP id hi2so2702937wib.7
        for <linux-mmc@vger.kernel.org>; Wed, 09 Jul 2014 05:59:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPDyKFoFNaFpDTVvMF3fbkrgYwUY1_hcbic89JyJzezFDRtN_w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice CHOTARD <patrice.chotard@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, kernel@stlinux.com, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>

Hi Ulf,

On Wed, 09 Jul 2014, Ulf Hansson wrote:

> On 4 June 2014 18:30, Peter Griffin <peter.griffin@linaro.org> wrote:
> > This platform driver adds initial support for the SDHCI host controller
> > found on STMicroelectronics SoCs.
> >
> > It has been tested on STiH41x b2020 platforms currently.
> >
> > Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
> 
> Thanks! Applied for next.

Can you drop this patch for the moment?

I was just rebasing the series for Maxime, and noticed this patch needs a few 
fixups to cope with Russell Kings recent changes in sdhci.c.

regards,

Peter.


