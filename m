Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F223B1DAC83;
	Fri,  4 Oct 2024 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728063304; cv=none; b=i+XgNU/MTUrhltzQ6FuoNDAKnxAcgLYidpI965NXqcbpPDhh0oHrQSutAZrRoKoKM0zpB0kU2wagJt7eSPE6D7rR9L7TSprQXzw11Xl2V4Rg62nL8x3B4E4dwEARJfC7yHRQOPt2jaESdfOJIDB9Q8ZmvASz2vvYI+yjDITGqIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728063304; c=relaxed/simple;
	bh=Dwv6noiDc4S+annH39h4WHteXeDc+xtZ7ECQ++m42CA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phOmjPIUUyO+smmn4os+TX12ZmLw5IqHhoOESyPNnAT83lWJjmK8RWwJ4OAMa7zSeXj7e+Wv0OJ7WnKsPyp1Z//RLgVlPFax+t2ctNmmkEBn5VxWXAQgbCi5CJO0QKIuU0t0U6COXI7j0W5oRfmXj3xktFjfcFTQeEZzShjBlRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94FCA339;
	Fri,  4 Oct 2024 10:35:28 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD75C3F640;
	Fri,  4 Oct 2024 10:34:57 -0700 (PDT)
Message-ID: <69d06c04-cc8c-4435-a622-33d5dcd1fa24@arm.com>
Date: Fri, 4 Oct 2024 18:34:33 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: dw_mmc: rockchip: Keep controller working for card
 detect
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, Jaehoon Chung
 <jh80.chung@samsung.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20240912152538.1.I858c2a0bf83606c8b59ba1ab6944978a398d2ac5@changeid>
 <4920950.GXAFRqVoOG@diego>
 <CAPDyKFosf_+m9j8YgHa-PsC2SV8+Aou2O6bTbMfzGBpQ2sY8YA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAPDyKFosf_+m9j8YgHa-PsC2SV8+Aou2O6bTbMfzGBpQ2sY8YA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/10/2024 10:55 pm, Ulf Hansson wrote:
> On Sat, 14 Sept 2024 at 13:52, Heiko Stübner <heiko@sntech.de> wrote:
>>
>> Am Donnerstag, 12. September 2024, 09:26:14 CEST schrieb Kever Yang:
>>> In order to make the SD card hotplug working we need the card detect
>>> function logic inside the controller always working. The runtime PM will
>>> gate the clock and the power domain, which stops controller working when
>>> no data transfer happen.
>>>
>>> So lets skip enable runtime PM when the card needs to detected by the
>>> controller and the card is removable.
>>>
>>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>>
>> So for the change itself this looks good, i.e. it fixes an issue for baords relying
>> on the on-chip-card-detect.
>>
>>
>> But for boards doing that, the controller will be running _all the time_
>> even if there is never any card inserted.
>>
>> So relying on the on-soc card-detect will effectively increase the power-
>> consumption of the board - even it it'll never use any sd-card?
> 
> Good point! A better option is to use a polling based mechanism - and
> we have MMC_CAP_NEEDS_POLL for exactly that.
> 
> Moreover, on DT based platforms one can even use the "broken-cd"
> property to indicate this.

Except that goes further than is needed here, since it would fall back 
entirely to software-based polling for card presence. In this case the 
CD function is not broken in terms of actually detecting a card, it just 
doesn't work to wake the controller up from suspend because it can't 
fire its own interrupt while powered off. In principle all we should 
require here is to periodically resume/suspend the device, to provide a 
window for the interrupt to work and normal operation to take over if 
appropriate.

Of course the really clever way would be for suspend to switch the pin 
into GPIO mode, and set the GPIO interrupt as a wakeup to trigger resume 
and switch it back again, but perhaps that's a bit tricky without 
explicit pinctrl states in the DT :/

Thanks,
Robin.

> 
> [...]
> 
> Kind regards
> Uffe
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
