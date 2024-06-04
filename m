Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4251384B1
	for <linux-mmc@vger.kernel.org>; Tue,  4 Jun 2024 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717487232; cv=none; b=jFf0jio76n1/m71L713g1KoatcijpZTqO1gtzgRK8akYnRt8OakqNhTb46RoNEhs9jb9ZdSKER4gAZnE10Q9rQQPXOKTwJxVWqYrf9tJixvF/fSmLBMp6d80lFzpTcoZUFN0w86q37H791+1xFCky6whxa9e/nx1tTyKEqQebmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717487232; c=relaxed/simple;
	bh=VZOqTzI1bjsVcWkAohJ6Ex/br4rhVQ+xrpZg0YL+YQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ohke6rThGCClnozEClukeUUsPnAHfsXNh1Iqfs4NUpoTvrHgRJcd0juNSyIvfFnU+66whiXpoMxcrLNhDAxKW1NZup8pZMSqsfJGLB1qZl5avlF6ciiYIAJGgExFbyGYiuZoaVDaU4IVq/ecYT55Ld7R9trwV4zpwzwfLZQH1Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26B4C1042;
	Tue,  4 Jun 2024 00:47:34 -0700 (PDT)
Received: from [10.57.86.243] (unknown [10.57.86.243])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72DCC3F762;
	Tue,  4 Jun 2024 00:47:08 -0700 (PDT)
Message-ID: <50bfdbf9-2ab0-4111-bf2e-abe4c9ed86fb@arm.com>
Date: Tue, 4 Jun 2024 08:47:06 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: obscure microsd detection issue between U-Boot and kernel
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <CAJ+vNU3Ns0RVtROcChGAhfO=XbpnzwQv1SehexbgHX6ST6-Piw@mail.gmail.com>
 <e0f38bc9-bcc2-4476-a5d4-4f2efaebc0c1@arm.com>
 <CAJ+vNU0jiVb4caYeQ5HYKZ-dqxcdG1K5pPisJZpfL4q7Sc3zvA@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJ+vNU0jiVb4caYeQ5HYKZ-dqxcdG1K5pPisJZpfL4q7Sc3zvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/3/24 22:28, Tim Harvey wrote:
> On Mon, Jun 3, 2024 at 1:18 AM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 5/31/24 21:47, Tim Harvey wrote:
>>> Greetings,
>>>
>>> I'm seeing an issue on an imx8mm board (imx8mm-venice-gw73xx) where
>>> for a specific set of microsd cards if I have accessed the microsd in
>>> U-Boot with UHS/1.8V the kernel will not recognize that microsd when
>>> scanning.
>>>
>>> The issue does not occur with all microsd cards but seems to appear
>>> with a large sample size of a specific card/model (Kingston SDC32 32GB
>>> SDR104 card). I do not see a signal integrity issue on the scope.
>>>
>>> Instrumenting the kernel the issue is that the host reports a CRC
>>> error as soon as the first mmc_send_if_cond call which occurs in
>>> mmc_rescan_try_freq.
>>>
>>> I can avoid the issue by either not accessing the microsd in U-Boot or
>>> by disabling UHS/1.8V mode in U-Boot therefore what I think is
>>> happening is that U-Boot leaves the card in UHS/1.8V signalling mode
>>> and when the kernel scans it sets the voltage back to 3.3V
>>> standard/default and default timings then issues its clock cycles to
>>> 'reset' the card and the card does not recognize the reset. I'm
>>> wondering if this is because the reset is done via clock cycles after
>>> the kernel has set the I/O voltage back to 3.3V when perhaps the card
>>> is still in 1.8V mode (although I don't see how that would cause an
>>> issue)?
>>
>> It will cause an issue for many cards and might break some cards.
>>
>>>
>>> Is there some sort of MMC 'reset' I can/should do in U-Boot before
>>> booting the kernel? Has anyone encountered anything like this before?
>>
>> There is no 'switching back' to 3.3V signalling from UHS 1.8V.
>> The only way this can be done is therefore a full power-off.
>> Is that done correctly for your system?
>> AFAIR spec dictates 500ms of <0.5V on VCC. Note that  driving CLK/signal
>> lines can also sustain the card somewhat, as leakage is only limited
>> within operating voltage.
> 
> Hi Christian,
> 
> Are you saying the only way to properly reset from 1.8V is to have a
> VDD supply on the microSD card that can be turned off before booting
> to Linux? We have never had that before and never encountered
> something like this.

Yes, the only safe way to use UHS-I really anyway.
You could disable UHS for u-boot but that still leaves (potentially)
problematic warm-reboots of the board.
Having a (software-controlled) switchable regulator on SD VCC is pretty
common for this reason and you should be able to find it in most dts
for host controllers with sd-uhs-* property.
I'm afraid that the relevant spec section isn't available in the
simplified version.

Kind Regards,
Christian
