From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC 1/2] pwrseq: Add subsystem to handle complex power sequences
Date: Tue, 1 Jul 2014 18:33:29 +0200
Message-ID: <CAPDyKFrgY9SER8t6O6saZDAi_BCOoqJy-mkEKxO0R8Qfy=052w@mail.gmail.com>
References: <1403183091-27876-1-git-send-email-ulf.hansson@linaro.org>
	<1403183091-27876-2-git-send-email-ulf.hansson@linaro.org>
	<53A2EDCA.8080000@redhat.com>
	<53A2F25E.80200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53A2F25E.80200@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 19 June 2014 16:23, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 06/19/2014 04:03 PM, Hans de Goede wrote:
>> Hi,
>>
>
> <snip>
>
>> Also I'm not sold on how you're making this a devm only thing, and
>> are using devres_alloc to not only allocate memory for resource tracking,
>> but also the actual backing struct, that is not how devres_alloc is
>> intended to be used AFAIK.
>>
>> A problem with having this one always devm managed is that it makes it
>> hard to use in library functions without side effects.
>>
>> e.g. if you look at how your using this in mmc_of_parse in the next
>> patch, this gives mmc_of_parse the side-effect of having allocated
>> and bound the power-seq method, even if mmc_of_parse later
>> fails on e.g. gpio binding. If then for some reason the mmc host
>> probe method decides to not propagate the mmc_of_parse method
>> error (leading to freeing of all devm managed resources), then this is
>> undesirable.
>>
>> Where as with a non devm version, it would be clear that on error
>> mmc_of_parse would need to explicitly release the pwrseq again.
>>
>> I realize that pwrseq implementations likely will want to use
>> devm functions too, and I'm a great fan of devm. But this is something
>> to keep in mind. At a minimum the description of of_mmc_parse needs
>> to get updated with info about it having potential side-effects even
>> when it fails, and that failure should always be treated as a fatal
>> error and cause the host probe method to fail.
>
> Thinking more about this, it may be a good idea to give the pwrseq
> its own struct device, turning it into a virtual device, this way the
> pwrseq-method can use devm managed resources bound to this device,
> we can set the of_node of this device to the actual powerseq
> childnode and it gets its own sysfs dir in which we could do useful things
> such as have an attribute to query the current power state.
>
> This would also mean introducing a non devm version of devm_pwrseq_get
> + an explicit release, which would be useful to avoid the side-effects
> mentioned above when used in library functions such as mmc_of_parse.

Hans, thanks for your comments. I will try to include all your ideas in a v2.

Kind regards
Uffe
