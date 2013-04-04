From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/4] mmc: sdhci-pxav3: misc enhancements
Date: Thu, 04 Apr 2013 10:04:03 -0400
Message-ID: <87vc82pf3g.fsf@octavius.laptop.org>
References: <1364204579-13307-1-git-send-email-kliu5@marvell.com>
	<CAN1soZwfgscQxWxV2G-jcOu+ckf5aWPzZHQuJ46japy-4A=tdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50511 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759986Ab3DDOEJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 4 Apr 2013 10:04:09 -0400
In-Reply-To: <CAN1soZwfgscQxWxV2G-jcOu+ckf5aWPzZHQuJ46japy-4A=tdQ@mail.gmail.com>
	(Haojian Zhuang's message of "Tue, 2 Apr 2013 15:49:42 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org, Zhangfei Gao <zhangfei.gao@gmail.com>

Hi,

Trimmed CC -- Kevin, please stop CC'ing so many people personally on
these patches.  That's what the mailing list's for.

On Tue, Apr 02 2013, Haojian Zhuang wrote:
> On Mon, Mar 25, 2013 at 5:42 PM, Kevin Liu <kliu5@marvell.com> wrote:
>>
>> This patchset aim to enhance sdhci-pxav3 with below patches (please get
>> detailed info in patch commmit message):
>> [PATCH RESEND 1/4] mmc: sdhci-pxav3: transfer sdhci_pltfm_data as arguments
>> [PATCH RESEND 2/4] mmc: sdhci-pxav3: remove cd-broken quirk for permanently
>> [PATCH RESEND 3/4] mmc: sdhci-pxav3: enhance device tree parser code
>> [PATCH RESEND v5 4/4] mmc: sdhci-pxav3: controller should use SDCLK for
>>
>> Kevin Liu (4):
>>  mmc: sdhci-pxav3: transfer sdhci_pltfm_data as arguments
>>  mmc: sdhci-pxav3: remove cd-broken quirk for permanently
>>  mmc: sdhci-pxav3: enhance device tree parser code
>>  mmc: sdhci-pxav3: controller should use SDCLK for
>>
>>  drivers/mmc/host/sdhci-pxav3.c | 47
>> ++++++++++++++--------------------------
>>  1 file changed, 16 insertions(+), 31 deletions(-)
>
> Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>

Thanks, all pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
