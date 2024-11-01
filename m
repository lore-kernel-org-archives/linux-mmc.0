Received: from mail-m19731120.qiye.163.com (mail-m19731120.qiye.163.com [220.197.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A553FF1;
	Fri,  1 Nov 2024 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730452501; cv=none; b=M7SxnrPpvLF5Iec8XP5Fys2pu/g0IfrfUB+456y4gai1wPcJxk/hzIvgyJaaB2QdpsZDmgpauqK0ftj5lKUFZLwXgbOi5lYjp5veSTncvct1vq9JMwQcuXoQn9msrqUyX+g120lWlMT4SUzSfLCPT5EUy1Uy/CDf+zhhI47OZ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730452501; c=relaxed/simple;
	bh=QeWofm20AbRL0tUJ6h2EObOvluRG9xxAampMZD1MHaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayjTVO63Sh7C/XjhouiizLFFJzQx8Aq0L7dwCMMvW6fbh/n4RRwMwVb6G4z8TmD7KIwBzF+uzTelD9YTHc5RKjDrzF7eSoeil0+aTPi8PGgqER/O4YpLEo7bncstTucad0648WknAO2URTNukv/VrnvsmLMCi0iS60dyThNlpZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Ns2PAmM3; arc=none smtp.client-ip=220.197.31.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Ns2PAmM3"
Received: from [172.16.12.67] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 183987c6;
	Fri, 1 Nov 2024 15:59:18 +0800 (GMT+08:00)
Message-ID: <eb96b240-f3ee-4057-b016-c746d48cc1b4@rock-chips.com>
Date: Fri, 1 Nov 2024 15:59:18 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: dw_mmc: rockchip: Keep controller working for card
 detect
To: Ulf Hansson <ulf.hansson@linaro.org>, Robin Murphy <robin.murphy@arm.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 linux-rockchip@lists.infradead.org, Jaehoon Chung <jh80.chung@samsung.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20240912152538.1.I858c2a0bf83606c8b59ba1ab6944978a398d2ac5@changeid>
 <4920950.GXAFRqVoOG@diego>
 <CAPDyKFosf_+m9j8YgHa-PsC2SV8+Aou2O6bTbMfzGBpQ2sY8YA@mail.gmail.com>
 <69d06c04-cc8c-4435-a622-33d5dcd1fa24@arm.com>
 <CAPDyKFoU=AoQqXov_-qFo8xjEbiDAk9mtTtCR9HAYz_gg-bnzQ@mail.gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <CAPDyKFoU=AoQqXov_-qFo8xjEbiDAk9mtTtCR9HAYz_gg-bnzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkwaQlYfQk8YQklLSh5PTUhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92e6bc62c103afkunm183987c6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRQ6Hzo5LjIjTE9KSUhIFxRW
	GkNPCz5VSlVKTEhLT09MQk5CTE5JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITkJMNwY+
DKIM-Signature:a=rsa-sha256;
	b=Ns2PAmM3r3IVo0z1BD9bWzhY49ezgnto/lCiZiqHcWvBOHPb/A16zDxfwiJa5XmD9Kq+7evbQpnVKcBtIO8uqQFV6WquR4xpX94n/2J949wt9rM7N+BKjxsdqrHzVtftHH5tHj1nP850u2tkMsiaKiyObzVPr06Dc1mNbEPFe5Y=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=UUxatgIjseNyDqt3FqqOob4pJSJxFWPR3CwFmtzwsvQ=;
	h=date:mime-version:subject:message-id:from;

Hi Ulf, Robin, Heiko,

On 2024/10/7 17:49, Ulf Hansson wrote:
> On Fri, 4 Oct 2024 at 19:34, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 02/10/2024 10:55 pm, Ulf Hansson wrote:
>>> On Sat, 14 Sept 2024 at 13:52, Heiko Stübner <heiko@sntech.de> wrote:
>>>> Am Donnerstag, 12. September 2024, 09:26:14 CEST schrieb Kever Yang:
>>>>> In order to make the SD card hotplug working we need the card detect
>>>>> function logic inside the controller always working. The runtime PM will
>>>>> gate the clock and the power domain, which stops controller working when
>>>>> no data transfer happen.
>>>>>
>>>>> So lets skip enable runtime PM when the card needs to detected by the
>>>>> controller and the card is removable.
>>>>>
>>>>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>>>> So for the change itself this looks good, i.e. it fixes an issue for baords relying
>>>> on the on-chip-card-detect.
>>>>
>>>>
>>>> But for boards doing that, the controller will be running _all the time_
>>>> even if there is never any card inserted.
>>>>
>>>> So relying on the on-soc card-detect will effectively increase the power-
>>>> consumption of the board - even it it'll never use any sd-card?
Yes, this is how the controller works, the controller needs the clock to 
make the detect logic work.
If we use gpio to implement this card-detect, it works because the GPIO 
controller/clock keeps working.
For the dw_mmc driver support, we should support both kind of implement 
due to the controller has this function,
so this patch is for the card-detect implement by the dwmmc controller, 
the controller need to keep working
- only for sd-card (so not include the "non-removable " device)
- also not disable rpm when "cd-gpios" is used.

For the power consumption, I believe it will increase, but very very 
small, we can't even monitor the change
if we use the normal equipment. The driver should make function works 
first, and then consider the power.

This patch is to make the dwmmc function works without gpio's help in 
dwmmc driver,
  and has no affect to the gpio option, people still able to use gpio to 
do the cd.


Thanks,
- Kever
>>> Good point! A better option is to use a polling based mechanism - and
>>> we have MMC_CAP_NEEDS_POLL for exactly that.
>>>
>>> Moreover, on DT based platforms one can even use the "broken-cd"
>>> property to indicate this.
>> Except that goes further than is needed here, since it would fall back
>> entirely to software-based polling for card presence. In this case the
>> CD function is not broken in terms of actually detecting a card, it just
>> doesn't work to wake the controller up from suspend because it can't
>> fire its own interrupt while powered off. In principle all we should
>> require here is to periodically resume/suspend the device, to provide a
>> window for the interrupt to work and normal operation to take over if
>> appropriate.
> Well, I would not object if "broken-cd" would be used for this case
> too. I believe it already is.
>
> Another option would be to look at a compatible string and set
> MMC_CAP_NEEDS_POLL based on that.
>
>> Of course the really clever way would be for suspend to switch the pin
>> into GPIO mode, and set the GPIO interrupt as a wakeup to trigger resume
>> and switch it back again, but perhaps that's a bit tricky without
>> explicit pinctrl states in the DT :/
> Right. A dedicated GPIO pin for the card detect is certainly the
> preferred method, if you care about not wasting power.
>
> Kind regards
> Uffe
