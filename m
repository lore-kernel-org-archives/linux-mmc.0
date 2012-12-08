From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH v6 11/14] mmc: sdhci: fix the bug that DDR50 can't work
 for emmc
Date: Sat, 8 Dec 2012 11:14:50 +0800
Message-ID: <CADz5_gLgQ1pT7=X=mDOZyRhpw0rmuMonOr9+Zx_qEc=eZ5jX5w@mail.gmail.com>
References: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
	<1350471893-29633-12-git-send-email-keyuan.liu@gmail.com>
	<87zk2f7t8h.fsf@octavius.laptop.org>
	<CADz5_gJq9vA1mhabMtupBaBqfNcwGV6TnkaOZwoLocwNgmLPFw@mail.gmail.com>
	<CADz5_g+ncZdBLQwSh2Vkia+OD7VtXuLtKFsp-z2bM8JJu10Sog@mail.gmail.com>
	<87r4n1bruo.fsf@octavius.laptop.org>
	<CADz5_gJfx6iZqx_007OKen+HviM2FJP5rnNbtnJoEPdqBg3SEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:44080 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932496Ab2LHDOv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Dec 2012 22:14:51 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm9so67132wib.1
        for <linux-mmc@vger.kernel.org>; Fri, 07 Dec 2012 19:14:50 -0800 (PST)
In-Reply-To: <CADz5_gJfx6iZqx_007OKen+HviM2FJP5rnNbtnJoEPdqBg3SEw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, Haojian Zhuang <haojian.zhuang@gmail.com>, cxie4@marvell.com, Philip Rakity <prakity@nvidia.com>, kliu5@marvell.com

2012/12/8 Kevin Liu <keyuan.liu@gmail.com>:
> 2012/12/8 Chris Ball <cjb@laptop.org>:
>> Hi,
>>
>> On Mon, Nov 19 2012, Kevin Liu wrote:
>>> In fact, I don't think 3.3v vccq for emmc can work under DDR50 mode
>>> with SD host.
>>
>> I've checked on the scope that we're reaching DDR50 with our 3.3V vccq
>> eMMC, so it looks like this isn't true.
>>
>
> Chris,
>
> Thanks for the check.
> If you are using sdhci-pxav3.c, 3.3v vccq can work since it enabled
> the 1.8v signaling in the callback function set_uhs_signaling.
> What I want to say is if you don't enable the 1.8v signaling bit while
> using 3.3v vccq, DDR50 on emmc should NOT work. (Use default sdhci
> code without implementing set_uhs_signaling as the other drivers.)
> You can just remove the set_uhs_signaling in sdhci-pxav3.c and try again.
> So we should do this in sdhci.c by default and remove the callback
> function, which only aim to enabling the 1.8v signaling bit.
>

Chris,

I would like to say more about my undersanding of 1.8v signaling bit
and UHS mode select. (Host Control 2 register, offset 0x3E<3:0>)
According to spec, when 1.8v signaling bit is set, the signaling
voltage will be changed from 3.3v to 1.8v. But we still provide 3.3v
vccq in current code. So originally I think it's conflictable in logic
and we must change to 1.8v vccq. But the fact is both 1.8v and 3.3v
vccq can work with 1.8v signaling bit set. The reason is below:
The host controller can't provide and totally control the card power by itself.
In actual implementation, the card power is supplied by external
regulator on board (vmmc and vmmcq) rather than host controller. So
for the 1.8v signaling bit, it will NOT impact signal voltage as spec
said either. It's just a flag but MUST be checked when UHS-I mode
selected. That's why we can enable 1.8v signaling bit while using 3.3v
vccq regulator for emmc DDR50 working. I confirmed this with mmp3 sdh
owner.

So we just enable the 1.8v signaling bit in host while keep 1.8v or
3.3v vccq regulator since emmc support DDR50 with both 1.8v and 3.3v
vccq. In other words, we make use of the incomplete feature of 1.8v
signaling bit (not matched with sd host spec that this bit should
control the signal voltage) to let both 3.3v and 1.8v signaling work
(well matched with JEDEC spec that DDR50 can work under both 1.8v and
3.3v vccq). I think it's good, otherwise only 1.8v can work which make
things complex and add limitation for board hardware.

So there are below conslusions:
1. If card power is supplied by external regulator, then setting 1.8v
signaling bit with both 1.8v and 3.3v vccq can work for emmc DDR50.
2. If host controller provide and totally control the card power, then
setting 1.8v signaling bit with only 1.8v vccq can work.
3. no matter which one of above two, 1.8v signaling bit MUST be set
for DDR50 working.
My patch assure item 3 in sdhci.c by default rather than adding
callback function to do this.

How do you think?

Thanks
Kevin
