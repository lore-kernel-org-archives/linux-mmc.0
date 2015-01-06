From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 1/3] mmc: dw_mmc: fix the max_blk_count in IDMAC
Date: Mon, 5 Jan 2015 19:10:29 -0800
Message-ID: <CAD=FV=W91znX4LhOWgE+Sk+Qb-+BN40bxU8dFDLn_RFpJ2=BqA@mail.gmail.com>
References: <1419250324-11743-1-git-send-email-alim.akhtar@samsung.com>
	<1419250324-11743-2-git-send-email-alim.akhtar@samsung.com>
	<CAD=FV=WQkkEM1aMPNX6oeKC4Bf2-D8z8uwf6z4btcdxiCpSvJw@mail.gmail.com>
	<CAGOxZ539VQ1fJbGpnJ-Awp0fQrU=-32zQYg4Tg8Vc67=8TnN+w@mail.gmail.com>
	<CAPz6YkV=j-E=tE-2-p0ukbQ0+GJWNtkY5uwA=VrFQ5s1OPm_GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:39430 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932130AbbAFDKa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jan 2015 22:10:30 -0500
Received: by mail-vc0-f181.google.com with SMTP id le20so8721699vcb.26
        for <linux-mmc@vger.kernel.org>; Mon, 05 Jan 2015 19:10:29 -0800 (PST)
In-Reply-To: <CAPz6YkV=j-E=tE-2-p0ukbQ0+GJWNtkY5uwA=VrFQ5s1OPm_GA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sonny Rao <sonnyrao@chromium.org>
Cc: Alim Akhtar <alim.akhtar@gmail.com>, Alim Akhtar <alim.akhtar@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

On Mon, Jan 5, 2015 at 6:27 PM, Sonny Rao <sonnyrao@chromium.org> wrote:
>> Do you see some performance degradation with some other variants of
>> dw_mmc host controller with current ToT?
>
> Looks like Doug test it and saw a performance improvement on rk3288
> Thanks!

Yup, all good.  I tested with mmc_test before and after this patch and
saw improvement.  I didn't test the old patch.

...only reason I commented originally was because I inspected the
patch and compared it to what we had before and saw that they were
different.  If you've though through all the conditions then I'm
happy.

-Doug
