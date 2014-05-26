From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
Date: Mon, 26 May 2014 18:07:18 +0200
Message-ID: <CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>
References: <537E31F7.1030505@gmail.com> <537F1148.3010102@redhat.com>
 <20140523112239.GB12304@sirena.org.uk>
 <537F3610.3050104@redhat.com>
 <20140523162718.GE22111@sirena.org.uk>
 <53806F26.6050706@redhat.com>
 <20140525123452.GS22111@sirena.org.uk>
 <53824294.1090609@redhat.com>
 <20140526103807.GV22111@sirena.org.uk>
 <538321AB.4050006@redhat.com>
 <20140526142225.GF22111@sirena.org.uk>
 <538356DA.7090302@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <538356DA.7090302@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: devicetree <devicetree@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Jyri Sarha <jsarha@ti.com>, Chris Ball <chris@printf.net>, Olof Johansson <olof@lixom.net>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Arend van Spriel <arend@broadcom.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

[snip]

>>
>> We don't typically actually bind multiple compatibles for a single
>> device.  We've got a bunch of options we can choose from but we
>> generally pick the one that matches best and ignore the others.
>>
>>> Where as what you're suggesting is to always pick driver foo, unless
>>> driver bar is available and has a special flag saying to not use foo, this
>>> is a whole new way to use compatibles really, and not one which I think
>>> we want to introduce.
>>
>> I'm not sure I'm buying the idea that we have a powerup driver that's
>> meaningfully not part of the main device driver.

I am having a bit hard to follow the terminology here. :-) What is a
"powerup driver" and what is a "main device driver" in this context?

I had a slide which I used at a mmc subsystem crash course recently,
please have a look - hopefully this will help us to sort out this.

https://drive.google.com/file/d/0B2ePGK-iqMupbDQ2S0o5b3Bhek0/edit?usp=sharing

>
> Well, if we merge some variant of Olof's code, we will have a powerup driver
> that is part of the mmc core, and thus not of the sdio function driver.
>
>>>> Well, if things aren't going to work either way for these devices
>>>> without extra stuff it seems it doesn't much matter but it helps the
>>>> simple case to have things default to working.
>>
>>> The simple case still needs a child node describing the needed resources,
>>> adding a compatible = "simple-sdio-powerup" to that at the same as creating
>>> the child node in the first place really is no extra effort at all.
>>
>> From where I'm sitting it's more effort since instead of just putting
>> the device in there (and possibly also some other devices that are
>> software compatible) we have to put in another compatible string which
>> is really just a boolean flag to be used in conjunction with the others.
>> That's harder to think about and we clearly don't want to go through the
>> compatible list, decide that we don't know how to handle the device
>> except power it up so go and do that.
>>
>> If it were done as something like "set boolean property X or
>> powerup-method = Y in the card description" or whatever it'd seem a bit
>> annoying but not a big deal, I think it's the fact that it's getting put
>> into the compatible list that's really concerning me.
>
> Ok, so lets switch it over to a boolean, options for the name I see are:
>
> linux,mmc-host-powerup  (opt in to powerup being dealt with by the mmc core, implementation specific)
> simple-powerup          (platform neutral opt in to say just enable all resources and be done with it)
> custom-powerup          (platform neutral opt out version of simple-powerup)
> linux,custom-powerup    (same, but consider this something linux specific)

This seems reasonable to me.

Well, I don't like the "simple-powerup", because I think a simple
powerup sequence is to me already supported by the mmc core, through
the regular host interface (->set_ios()).

If I understand correctly, this binding is supposed to be configured
per host device and thus also per host device slots?

Kind regards
Ulf Hansson
