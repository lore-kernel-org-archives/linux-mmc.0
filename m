From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFC v4 01/14] regulator: of: Add helper for getting all supplies
Date: Thu, 09 Jun 2016 13:42:02 +0200
Message-ID: <5759560A.70107@samsung.com>
References: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
 <1465465471-28740-2-git-send-email-k.kozlowski@samsung.com>
 <20160609102925.GS7510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:8426 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbcFILmJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2016 07:42:09 -0400
In-reply-to: <20160609102925.GS7510@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, hzpeterchen@gmail.com, Bartlomiej

On 06/09/2016 12:29 PM, Mark Brown wrote:
> On Thu, Jun 09, 2016 at 11:44:18AM +0200, Krzysztof Kozlowski wrote:
>> Few drivers have a need of getting regulator supplies without knowing
>> their names:
>> 1. The Simple Framebuffer driver works on setup provided by bootloader
>>    (outside of scope of kernel);
>> 2. Generic power sequence driver may be attached to any device node.
>>
>> Add a Device Tree helper for parsing "-supply" properties and returning
>> allocated bulk regulator consumers.
> 
> I'm still very concerned that this is just an invitation to people to
> write half baked regulator consumers and half baked DTs to go along with
> it, making it a standard API that doesn't have big red flags on it that
> will flag up when "normal" drivers use it is not good.  Right now this
> just looks like a standard API and people are going to just start using
> it.  If we are going to do this perhaps we need a separate header or
> something to help flag this up.

No problem, I can move it to a special header.  Actually, if you dislike
this as an API, it does not have to be in header at all.  I can just
duplicate the simplefb code.

> In the case of power sequences I'd expect the sequences to perform
> operations on named supplies - the core shouldn't know what the supplies
> are but the thing specifying the sequence should.

Hm, so maybe passing names like:

usb3503@08 {
	reset-gpios = <&gpx3 5 GPIO_ACTIVE_HIGH>;
	initial-mode = <1>;
	vdd-supply = <&buck8_reg>;
	foo-supply = <&buck9_reg>;

        power-sequence;
	power-sequence-supplies = "vdd", "foo";
};

but this is getting against initial idea of not adding any
power-sequence properties.

> 
>>  drivers/regulator/of_regulator.c       | 86 ++++++++++++++++++++++++++++++++++
>>  include/linux/regulator/of_regulator.h | 13 +++++
>>  2 files changed, 99 insertions(+)
> 
> The external interface shouldn't be DT specific, the Intel people are
> busy importing all of DT into ACPI so they'll doubtless want an ACPI
> version.

Sure, I'll add it if this approach is acceptable.  At this moment this
is not necessary to show my idea so I prefer to avoid doing work which
might be discarded very fast by review.

Thanks for feedback!

Best regards,
Krzysztof
