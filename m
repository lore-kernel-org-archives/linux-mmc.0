From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: Add hardware dependencies for sdhci-pxav3 and sdhci-pxav2
Date: Fri, 30 Jan 2015 11:43:17 +0100
Message-ID: <CAPDyKFq+Abjfyynnw+cQrEVUYKx1xwWtY9fr1mbKAMD502qjpw@mail.gmail.com>
References: <20150126112328.318da5e7@endymion.delvare>
	<CAPDyKFo363x7NGEctNwHkpn-6HkAu15qu-ZFtt73mJcWZrce4g@mail.gmail.com>
	<1422369244.4499.187.camel@chaos.site>
	<CAPDyKFqWa0uyZStNT1Wp21HpSqYpfJx3wU3TDJy25uMgG7qZaw@mail.gmail.com>
	<20150129151711.454100be@endymion.delvare>
	<CAPDyKFohbn3yG9iuj7WbV0mDY4H4jZe3SgihGSdOqPLKkTMdZQ@mail.gmail.com>
	<20150130092913.6256e517@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150130092913.6256e517@endymion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-mmc@vger.kernel.org

On 30 January 2015 at 09:29, Jean Delvare <jdelvare@suse.de> wrote:
> Hi Ulf,
>
> On Thu, 29 Jan 2015 16:01:48 +0100, Ulf Hansson wrote:
>> On 29 January 2015 at 15:17, Jean Delvare <jdelvare@suse.de> wrote:
>> > On Wed, 28 Jan 2015 15:04:24 +0100, Ulf Hansson wrote:
>> >> For those SOC that want these drivers, they should be able to select
>> >> them from their defconfigs. So it will be an opt-in instead of opt-out
>> >> policy, which I prefer. It also follows the other Kconfig options for
>> >> mmc drivers.
>> >
>> > As you wish. But that change would be a separate patch going on top of
>> > mine, right? I'm not sure I understand what you expect from me at this
>> > point, please clarify.
>>
>> Sorry for being unclear. I don't like $subject patch.
>>
>> Send a new one, removing the following lines:
>> default CPU_MMP2
>> default CPU_PXA910
>>
>> Then you send another patch(es) to the respective SOC maintainer,
>> updating the defonfig(s) selecting MMC_SDHCI_PXAV3|PXAV2, when
>> appropriate.
>>
>> Would that work?
>
> Not really, I'm afraid.
>
> My proposed change affects users of non-embedded systems, or more
> generally everyone not on ARCH_MMP. I want to make their life easier by
> hiding options which are not relevant to them. I have sent several
> dozen of such patches in the past for various drivers, see for example
> the latest ones:
>   http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=441fb7684782be3553c67dc04defcf304b999bba
>   http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c03842d89b769db44be5cb0b1ebb384ccfa25f7f
>   http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=84c3a8f6eadb2bedfba10f62da0328d8533c8f25
> Also note that the MMC subsystem already has examples of this, check
> MMC_OMAP_HS, MMC_SDHCI_MSM, MMC_SDHI, MMC_DW and MMC_SH_MMCIF in
> drivers/mmc/host/Kconfig. I'm just doing more of the same, nothing new.
>
> The change you want, OTOH, would affect exclusively the ARCH_MMP users
> (of which I am not.) It is essentially unrelated with what I was
> originally talking about, except for the fact that it touches the same
> Kconfig entries. I have no idea if your proposal is a good idea, I am
> not dealing with embedded systems, and I have no idea who are the
> maintainers of the affected SOCs. This is simply not my area.
>
> So basically you are rejecting my proposal without a reason, and then
> you ask me to do an unrelated work instead. This is not fair, sorry.
>
> Don't get me wrong, I'm always ready to do some more work than I
> originally intended if that's what it takes to get my patches merged. I
> value code review and I welcome constructive criticism. But this time
> your request is not reasonable.

I did a little more of investigation of what's good practice/policy
around your suggested patch. I have changed my mind, I am going to
accept your patch as is.

Sorry for all the noise and thanks for a good discussion.

Applied for next. Thanks!

Kind regards
Uffe
