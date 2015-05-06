From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: dw_mci_get_cd check MMC_CAP_NONREMOVABLE
Date: Wed, 6 May 2015 09:14:15 +0800
Message-ID: <CABQgh9E5B=q-5+go2FJXUbDpveGm2xEo+1LdKbG40sxrZ7vQnA@mail.gmail.com>
References: <1430816089-8857-1-git-send-email-zhangfei.gao@linaro.org>
	<55496227.9000904@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36138 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbbEFBOQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 21:14:16 -0400
Received: by wizk4 with SMTP id k4so183191376wiz.1
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2015 18:14:15 -0700 (PDT)
In-Reply-To: <55496227.9000904@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 6 May 2015 at 08:36, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi, Zhangfei.
>
> If you want to check it, use the "broken-cd" and "non-removable" properties into dt-file.
> Did you use them?

Yes.
"broken-cd" can work, but mmc_rescan keeps running.
"non-removable" does NOT work, which should be used for emmc.
Since dw_mci_get_cd only checks DW_MCI_QUIRK_BROKEN_CARD_DETECTION, so
only checks "broken-cd" but not check "non-removable"

Thanks
