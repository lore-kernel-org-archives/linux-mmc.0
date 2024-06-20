Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B29A38389
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 18:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909202; cv=none; b=ucyIyvtnlqm3rK18thffhrEtrgfQaXYAARrjz2/GDtXIkcqKTKJDm9urVutkEzT0x+mKBxrOn9r7NBiGQP73O8RoGxzIf2rbsTLOJ3gPvisBR6OA/IY0zpMiQURGBP1WAlr0U6ZaBMa+L32kp31JAJ+17psLvXwkmtNunmpqLRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909202; c=relaxed/simple;
	bh=c/wF2cYPFBGpxQdakAkYX1eiUZfBZatIO9yZbUFel4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AkyB8bu6MGNrYfcde1Cr2mUhEIqZXSj/vsxhDPBgJMRkUFfiPX5qPOfE3IrUGaYWd2o3JycPOnDtB/86B7wY8XrzLvfsYYmGybk02ptd/qGnqdw/wgU0o034+kj9pSABTlxcUw6/W8N6yQ2Ry1/Fpw1fj8FKi+fcO5Uvun05NSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E6B6DA7;
	Thu, 20 Jun 2024 11:47:03 -0700 (PDT)
Received: from [10.57.69.158] (unknown [10.57.69.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF35B3F6A8;
	Thu, 20 Jun 2024 11:46:36 -0700 (PDT)
Message-ID: <c20f1134-468c-4d5c-aa70-0562d24c36ac@arm.com>
Date: Thu, 20 Jun 2024 19:46:34 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: obscure microsd detection issue between U-Boot and kernel
To: Tim Harvey <tharvey@gateworks.com>, Michael Walle <michael@walle.cc>
Cc: u-boot <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <CAJ+vNU3Ns0RVtROcChGAhfO=XbpnzwQv1SehexbgHX6ST6-Piw@mail.gmail.com>
 <e0f38bc9-bcc2-4476-a5d4-4f2efaebc0c1@arm.com>
 <CAJ+vNU0jiVb4caYeQ5HYKZ-dqxcdG1K5pPisJZpfL4q7Sc3zvA@mail.gmail.com>
 <50bfdbf9-2ab0-4111-bf2e-abe4c9ed86fb@arm.com>
 <D1R2ZW5Q12QQ.OU52AZIYS68O@walle.cc>
 <CAJ+vNU2zu5jwr_jScDN3Xs9-PV0yKyPVqOLBK504i79veAu+Lw@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJ+vNU2zu5jwr_jScDN3Xs9-PV0yKyPVqOLBK504i79veAu+Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/20/24 17:48, Tim Harvey wrote:
> On Tue, Jun 4, 2024 at 1:14 AM Michael Walle <michael@walle.cc> wrote:
>>
>> On Tue Jun 4, 2024 at 9:47 AM CEST, Christian Loehle wrote:
>>> On 6/3/24 22:28, Tim Harvey wrote:
>>>> On Mon, Jun 3, 2024 at 1:18 AM Christian Loehle
>>>> <christian.loehle@arm.com> wrote:
>>>>>
>>>>> On 5/31/24 21:47, Tim Harvey wrote:
>>>>>> Greetings,
>>>>>>
>>>>>> I'm seeing an issue on an imx8mm board (imx8mm-venice-gw73xx) where
>>>>>> for a specific set of microsd cards if I have accessed the microsd in
>>>>>> U-Boot with UHS/1.8V the kernel will not recognize that microsd when
>>>>>> scanning.
>>>>>>
>>>>>> The issue does not occur with all microsd cards but seems to appear
>>>>>> with a large sample size of a specific card/model (Kingston SDC32 32GB
>>>>>> SDR104 card). I do not see a signal integrity issue on the scope.
>>>>>>
>>>>>> Instrumenting the kernel the issue is that the host reports a CRC
>>>>>> error as soon as the first mmc_send_if_cond call which occurs in
>>>>>> mmc_rescan_try_freq.
>>>>>>
>>>>>> I can avoid the issue by either not accessing the microsd in U-Boot or
>>>>>> by disabling UHS/1.8V mode in U-Boot therefore what I think is
>>>>>> happening is that U-Boot leaves the card in UHS/1.8V signalling mode
>>>>>> and when the kernel scans it sets the voltage back to 3.3V
>>>>>> standard/default and default timings then issues its clock cycles to
>>>>>> 'reset' the card and the card does not recognize the reset. I'm
>>>>>> wondering if this is because the reset is done via clock cycles after
>>>>>> the kernel has set the I/O voltage back to 3.3V when perhaps the card
>>>>>> is still in 1.8V mode (although I don't see how that would cause an
>>>>>> issue)?
>>>>>
>>>>> It will cause an issue for many cards and might break some cards.
>>>>>
>>>>>>
>>>>>> Is there some sort of MMC 'reset' I can/should do in U-Boot before
>>>>>> booting the kernel? Has anyone encountered anything like this before?
>>>>>
>>>>> There is no 'switching back' to 3.3V signalling from UHS 1.8V.
>>>>> The only way this can be done is therefore a full power-off.
>>>>> Is that done correctly for your system?
>>>>> AFAIR spec dictates 500ms of <0.5V on VCC. Note that  driving CLK/signal
>>>>> lines can also sustain the card somewhat, as leakage is only limited
>>>>> within operating voltage.
>>>>
>>>> Hi Christian,
>>>>
>>>> Are you saying the only way to properly reset from 1.8V is to have a
>>>> VDD supply on the microSD card that can be turned off before booting
>>>> to Linux? We have never had that before and never encountered
>>>> something like this.
>>>
>>> Yes, the only safe way to use UHS-I really anyway.
>>
>> I can second that. And also keep in mind that the actual supply
>> voltage must be below that threshold. Thus, the power-off time also
>> depends on the capacitance on that supply line after the power load
>> switch. There are switches with dedicated output discharge circuits
>> built-in.
>>
>> That being said, from my experience there are cards which will work
>> when switching back from 1V8 to 3V3 signalling and some don't. I
>> haven't digged deeper into that topic, though.
>>
>> -michael
>>
>>> You could disable UHS for u-boot but that still leaves (potentially)
>>> problematic warm-reboots of the board.
>>> Having a (software-controlled) switchable regulator on SD VCC is pretty
>>> common for this reason and you should be able to find it in most dts
>>> for host controllers with sd-uhs-* property.
>>> I'm afraid that the relevant spec section isn't available in the
>>> simplified version.
>>>
>>> Kind Regards,
>>> Christian
>>
> 
> Thanks for both of your responses here!
> 
> I have a situation where I can re-create a problem switching from 1.8V
> back to 3.3V with a specific card on a board that has ESD protection
> between the IMX8MM host and the microSD connector (Semtech
> ECLAMP2410P.TCT [1]) but works just fine on a previous revision of
> that same PCB that does not have the ESD protection added. Boards with
> proper ESD protection are the first time I've seen this issue occur.
> Does this make sense at all?

I have some hypothesis but that isn't even worth sharing, see below.

> 
> I believe that the MMC device is 'reset' via a series of CLK cycles
> with CMD/DAT non-asserted so I'm having a difficult time understanding
> how this wouldn't work if the host has been reset to 3.3V.

My answer is simple but not very satisfying:
It is out of spec.
After the CMD11 UHS voltage switch anything on CMD, DAT and CLK you
drive from the host at 3.3V without a proper powercycle is out of spec,
the card's behavior isn't covered by the SD spec and the card isn't to
blame.

If you want a really detailed answer try asking your SD card vendor,
my guess would be their answer is "the host is out of spec".

Kind Regards,
Christian

