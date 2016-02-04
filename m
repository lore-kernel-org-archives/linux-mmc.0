From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4] mmc: meson: Add driver for the SD/MMC host found on
 Amlogic MesonX SoCs
Date: Thu, 4 Feb 2016 11:34:16 +0100
Message-ID: <CAPDyKFqpgEtAvK9HesdA5tLuj7htUmo5ZrvbDC0wCzHB3=_-xQ@mail.gmail.com>
References: <1448988109-32630-1-git-send-email-carlo@caione.org>
	<CAPDyKFp=buvJ8Li3XC8XSUAUO7BsE+U6vEQH2xTrgcHAkdG8bQ@mail.gmail.com>
	<CAOQ7t2aJAPWd3Xmvu7n0EWL-KC8ZriM3KryfsYEh556uXhuR+g@mail.gmail.com>
	<CAPDyKFpcsKihuOiF5=RwoWrF0Jf7hRsXVSU5uV8qZf1mUsa-iQ@mail.gmail.com>
	<CAOQ7t2afXxStCsj=M-FX7eMep1gLt4jkyXDiLas_SQ1UwHc0=Q@mail.gmail.com>
	<CAPDyKFpX+_fHvv_bJUKZmSufKKnuONC582E7u3b20a+Rbbggng@mail.gmail.com>
	<CAOQ7t2aS0yRDhM3+8wW5xrycG371uthDJy6U_oDAZip4jHRiRA@mail.gmail.com>
	<CAPDyKFo=LdzFsELZJKXj_CDcNYj96J4Q9-KqS63041d3BVUEDQ@mail.gmail.com>
	<CAOQ7t2aF=wzYHF8LXK5WVMJ=mEDHzfvbL=iRvorq+FZshL0q0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:33081 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964780AbcBDKeR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Feb 2016 05:34:17 -0500
Received: by mail-yw0-f176.google.com with SMTP id z185so23971585ywf.0
        for <linux-mmc@vger.kernel.org>; Thu, 04 Feb 2016 02:34:17 -0800 (PST)
In-Reply-To: <CAOQ7t2aF=wzYHF8LXK5WVMJ=mEDHzfvbL=iRvorq+FZshL0q0g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-meson@googlegroups.com, linux@endlessm.com

On 4 February 2016 at 10:12, Carlo Caione <carlo@caione.org> wrote:
> On Wed, Feb 3, 2016 at 11:46 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 2 February 2016 at 22:54, Carlo Caione <carlo@caione.org> wrote:
>
> [cut]
>
>> Huh, another broken MMC controller. :-)
>
> Oh, actually I found in the datasheet a couple of undocumented
> registers (also not used in the original Amlogic SDK code) that seems
> to have something to do with timeout (hard to say without proper
> documentation but they are called "Timeout counter for preload setting
> and present status" and "Timeout Counter Interrupt Enable for ARC/ARM"
> so I guess I'm on the right track here).
> I briefly tried yesterday to enable this timeout interrupt with a
> dummy value in the counter register (I have no idea how get this value
> from the clocking) and it seems working (the counter value is
> decremented when reading the register upon command completion).

Let's hope this works, as this will for sure be a better solution.

>
>> In some cases there are no data in the request, it's just a command
>> being sent. So to deal with this issue, you will have to adjust the
>> timer depending on the request we send to the controller.
>
> I see that the CMD13 used to poll the card has no data so in that case
> should we use a fixed / dummy value to use as timeout counter?
> I'm kind of confused here since the MMC drivers I'm looking at use the
> hardware timeout register only when the data->timeout_ns is actually
> present.

That's a different timeout value. It's elated to *each* block data
transfer and not the entire request. So it provides information to the
controller about what delays it shall accept during a block being
written/read.

More details is found in the electrical descriptions of the interface
in the eMMC/SD spec.

Kind regards
Uffe
