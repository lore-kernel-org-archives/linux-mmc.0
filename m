From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v6 0/6] update selection of bus speed mode for eMMC
Date: Mon, 21 Apr 2014 12:55:21 +0900
Message-ID: <000001cf5d15$84587600$8d096200$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <006701cf2a58$c628e050$527aa0f0$%jun@samsung.com>
 <001301cf5b0b$2ffe5a40$8ffb0ec0$%jun@samsung.com>
 <CAPDyKFpHasn88pi6o3Hf7pZhj9wr9UHK=ui9PzpQvA66_=fivA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:36640 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbaDUDzX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Apr 2014 23:55:23 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N4D00BZH489LY90@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 21 Apr 2014 12:55:21 +0900 (KST)
In-reply-to: <CAPDyKFpHasn88pi6o3Hf7pZhj9wr9UHK=ui9PzpQvA66_=fivA@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Ulf Hansson' <ulf.hansson@linaro.org>
Cc: 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Chris Ball' <chris@printf.net>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Jackey Shen' <jackey.shen@amd.com>, 'Alim Akhtar' <alim.akhtar@samsung.com>

On Sun, April 20, 2014, Ulf Hansson wrote:
> Hi Seungwon,
> 
> On 18 April 2014 15:36, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > This series contains the change for selection of bus speed mode.
> > Previous implementation is complicated and some sequence is duplicated.
> > And specially, HS400 mode eMMC5.0 is introduced this time.
> > This patch-set has been tested in Exynos SoC.
> >
> > Note:
> > This patch-set depends on "[PATCH RESEND v3 1/7] mmc: clarify DDR timing mode between SD-UHS and
> eMMC".
> >
> > Changes in v6:
> >         (6/6) Included "mmc: core: add DT bindings for eMMC HS400 1.8/1.2V" into this patch-set
> >         (5/6) Changed return type of prepare_hs400_tuning callback(int -> void)
> 
> I would favour the int return type, that leaves room for the
> possibility of drivers to fail.
> 
> Moreover, I have already sent a pull request to Chris, with the v5
> version of this patchset, which I think is fine.
OK. It would be fine.

Thanks,
Seungwon Jeon


