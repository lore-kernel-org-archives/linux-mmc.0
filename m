From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in device
 tree
Date: Mon, 26 May 2014 13:12:43 +0200
Message-ID: <538321AB.4050006@redhat.com>
References: <CAGb2v64VZac2KvAALrScecN89sRnBQoDrKxKMvkte+3G04NXeA@mail.gmail.com> <537DE1AA.5050606@redhat.com> <537E31F7.1030505@gmail.com> <537F1148.3010102@redhat.com> <20140523112239.GB12304@sirena.org.uk> <537F3610.3050104@redhat.com> <20140523162718.GE22111@sirena.org.uk> <53806F26.6050706@redhat.com> <20140525123452.GS22111@sirena.org.uk> <53824294.1090609@redhat.com> <20140526103807.GV22111@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25473 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639AbaEZLNn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 26 May 2014 07:13:43 -0400
In-Reply-To: <20140526103807.GV22111@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>

Hi,

On 05/26/2014 12:38 PM, Mark Brown wrote:
> On Sun, May 25, 2014 at 09:20:52PM +0200, Hans de Goede wrote:

<snip>

>> Also the mmc people are very much against specifying a driver, as that is
>> something which should be probed not specified. I agree with them I've
>> already seen boards were more or less standardized sdio modules from different
>> vendors are used, they have various standard sdio powerup related things, like
>> an enable signal in standard places, but different editions of the boards
>> have different sdio modules soldered on, using different drivers.
> 
> If the device isn't specified then presumably it'll power up with the
> default sequence so we shouldn't need to worry about overriding anything
> until we've powered up and enumerated.  The only time that there's a
> problem and would need to specify exactly what the device is in the DTS
> is if we need the custom sequence prior to being able to do that at
> which point I don't see much option.

Specified != driver available. Determining whether or not we should power
up based purely on there being a compatible string is not going to work, as
even when using simple powerup we still need compatible strings for non
powerup settings like sdio signal drive strength, oob irq, etc.

So the only way this will work is if we delay powerup until we've a driver
available, which may be never if the module is not build, or whatever,
and without powerup the user is never going to figure out he is missing
a module. Basically adding a driver flag for blacklisting from the simple
power up logic means inserting an unnecessary initialization ordering issue,
which we really don't need as each ordering dependency is usually one too many.

> 
>> I know that the DT is an ABI, and I'm not arguing for removing support for
>> the simple-sdio-powerup compatible from the kernel when a more complex
>> case arrives, nor am I arguing to remove it from the DT for existing working
>> boards. The idea behind the simple-sdio-powerup compatible is that it makes
>> the simple powerup behavior opt-in. So if a new board comes along which
>> requires something more complex, the people working on this can do what ever
>> they want / need without the simple powerup code getting in the way, as
>> long as they don't *add* the simple-sdio-powerup compatible to their *new*
>> DT file.
> 
> I don't understand why not powering the device up would be a sensible
> default or why other OSs would also choose to implement things that way.

Because if we are not 100% sure that our simple power up logic will do the
job properly (i.e. in the right order), then the SAFE thing to do is to
not power up.

> It would seem more natural that we would have the custom override in
> place for things that need special handling, not the other way around -
> I think that's really the difference between what we're saying.

Normally I would agree with you, but doing powerup the wrong way is not
necessarily safe, so we really should not go and enable stuff just
because it is there (most of it will used standardized properties even for
custom power up sequences).

What if a user takes an older distro kernel, where the driver does not
set the opt-out flag you're suggesting since at that time it did not
have its own power logic, then tries to boot that with a dtb file written
for a newer kernel (where the driver does have the opt out flag), and we
start powering up things in the wrong order and let the magic smoke out
of various components on the board ?

> My expectation would be that we do the standard case by default and then
> have the complex cases override rather than the other way around, that
> way the standard case just works with no effort.

Adding "compatible = "simple-sdio-powerup" to the child node which has
the properties specifying which clks, etc. to enable really is no effort,
esp. since this will be done at the same time as creating the child nodes
in the first place.

Also note that this is a perfectly standard use of compatibles, compatibles
are typically used to indicate which driver should be used, in this case
the compatible indicates that the simple powerup driver should be used,
where as if another powerup driver should be used another compatbile will
be there instead.

Where as what you're suggesting is to always pick driver foo, unless
driver bar is available and has a special flag saying to not use foo, this
is a whole new way to use compatibles really, and not one which I think
we want to introduce.



> 
>> Basically the idea behind the simple-sdio-powerup compatible is to make
>> the worst case scenario for more complex boards to be the scenario which
>> we have today, i.e. no support for sdio powerup at all, rather then having
>> something in place which actually may get in the way, making things worse
>> then they are today.
> 
> Well, if things aren't going to work either way for these devices
> without extra stuff it seems it doesn't much matter but it helps the
> simple case to have things default to working.

The simple case still needs a child node describing the needed resources,
adding a compatible = "simple-sdio-powerup" to that at the same as creating
the child node in the first place really is no extra effort at all.

Regards,

Hans
