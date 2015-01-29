From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: Add hardware dependencies for sdhci-pxav3 and sdhci-pxav2
Date: Thu, 29 Jan 2015 16:01:48 +0100
Message-ID: <CAPDyKFohbn3yG9iuj7WbV0mDY4H4jZe3SgihGSdOqPLKkTMdZQ@mail.gmail.com>
References: <20150126112328.318da5e7@endymion.delvare>
	<CAPDyKFo363x7NGEctNwHkpn-6HkAu15qu-ZFtt73mJcWZrce4g@mail.gmail.com>
	<1422369244.4499.187.camel@chaos.site>
	<CAPDyKFqWa0uyZStNT1Wp21HpSqYpfJx3wU3TDJy25uMgG7qZaw@mail.gmail.com>
	<20150129151711.454100be@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150129151711.454100be@endymion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-mmc@vger.kernel.org

On 29 January 2015 at 15:17, Jean Delvare <jdelvare@suse.de> wrote:
> Hi Ulf,
>
> On Wed, 28 Jan 2015 15:04:24 +0100, Ulf Hansson wrote:
>> On 27 January 2015 at 15:34, Jean Delvare <jdelvare@suse.de> wrote:
>> > Hi Ulf,
>> >
>> > Le Tuesday 27 January 2015 =C3=A0 15:06 +0100, Ulf Hansson a =C3=A9=
crit :
>> >> On 26 January 2015 at 11:23, Jean Delvare <jdelvare@suse.de> wrot=
e:
>> >> > I seem to understand that the sdhci-pxav3 and sdhci-pxav2 drive=
rs are
>> >> > only needed on the MMP architecture. So add a hardware dependen=
cy on
>> >> > ARCH_MMP, so that other users don't get to build useless driver=
s.
>> >>
>> >> I would rather see the default option to be N.
>> >> Thus those configurations that needs this driver will have to sel=
ect it.
>> >
>> > This is a different question. The purpose of my patch is that peop=
le
>> > configuring kernels for systems which just can't have these contro=
llers,
>> > are not asked about this driver at all. Changing the default to N =
would
>> > not achieve that.
>>
>> For those SOC that want these drivers, they should be able to select
>> them from their defconfigs. So it will be an opt-in instead of opt-o=
ut
>> policy, which I prefer. It also follows the other Kconfig options fo=
r
>> mmc drivers.
>
> As you wish. But that change would be a separate patch going on top o=
f
> mine, right? I'm not sure I understand what you expect from me at thi=
s
> point, please clarify.

Sorry for being unclear. I don't like $subject patch.

Send a new one, removing the following lines:
default CPU_MMP2
default CPU_PXA910

Then you send another patch(es) to the respective SOC maintainer,
updating the defonfig(s) selecting MMC_SDHCI_PXAV3|PXAV2, when
appropriate.

Would that work?

Kind regards
Uffe
