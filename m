From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/5] mmc: sdhci-pltfm: Do not use parent as the host's device
Date: Mon, 11 Aug 2014 11:07:57 +0200
Message-ID: <CAPDyKFoLU6pnJFmKe7CB0q-hKfwv4uCPSr0cE4aoYMvfhjMteQ@mail.gmail.com>
References: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>
	<1406298233-27876-3-git-send-email-pawel.moll@arm.com>
	<1407515785.31897.28.camel@hornet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1407515785.31897.28.camel@hornet>
Sender: linux-kernel-owner@vger.kernel.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Olof Johansson <olof@lixom.net>, Stephen Warren <swarren@wwwdotorg.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "paul@pwsan.com" <paul@pwsan.com>, Arnd Bergmann <arnd@arndb.de>, Peter De Schrijver <pdeschrijver@nvidia.com>, "arm@kernel.org" <arm@kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-mmc@vger.kernel.org

On 8 August 2014 18:36, Pawel Moll <pawel.moll@arm.com> wrote:
> On Fri, 2014-07-25 at 15:23 +0100, Pawel Moll wrote:
>> The code selecting a device for the sdhci host has been
>> continuously tweaked (4b711cb13843f5082e82970dd1e8031383134a65
>> "mmc: sdhci-pltfm: Add structure for host-specific data" and
>> a4d2177f00a5252d825236c5124bc1e9918bdb41 "mmc: sdhci-pltfm: dt
>> device does not pass parent to sdhci_alloc_host") while there
>> does not seem to be any reason to use platform device's parent
>> in the first place.
>>
>> The comment saying "Some PCI-based MFD need the parent here"
>> seem to refer to Timberdale FPGA driver (the only MFD driver
>> registering SDHCI cell, drivers/mfd/timberdale.c) but again,
>> the only situation when parent device matter is runtime PM,
>> which is not implemented for Timberdale.
>>
>> Cc: Chris Ball <chris@printf.net>
>> Cc: Anton Vorontsov <anton@enomsg.org>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: linux-mmc@vger.kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
>> ---
>>
>> This patch is a part of effort to remove references to platform_bus
>> and make it static.
>>
>> Chris, Anton, Ulf - could you please advise if the assumptions
>> above are correct or if I'm completely wrong? Do you know what
>> where the real reasons to use parent originally? The PCI comment
>> seems like a red herring to me...
>
> Can I take the silence as a suggestion that the change looks ok-ish f=
or
> you?

Sorry for the delay. I suppose this make sense, but I really don't
know for sure.

I guess we need some testing in linux-next, to get some confidence.

Kind regards
Uffe

>
> Pawe=C5=82
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
