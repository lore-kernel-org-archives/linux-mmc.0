From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC v4 01/14] regulator: of: Add helper for getting all supplies
Date: Thu, 9 Jun 2016 14:50:26 +0200
Message-ID: <CAJZ5v0hiyyOhU7AjOEjFHjTKhT+pqWZheUG77c6u2HV9dNQ0Gg@mail.gmail.com>
References: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
 <1465465471-28740-2-git-send-email-k.kozlowski@samsung.com> <20160609102925.GS7510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33086 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbcFIMu3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2016 08:50:29 -0400
In-Reply-To: <20160609102925.GS7510@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>linu

On Thu, Jun 9, 2016 at 12:29 PM, Mark Brown <broonie@kernel.org> wrote:
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
>
> In the case of power sequences I'd expect the sequences to perform
> operations on named supplies - the core shouldn't know what the supplies
> are but the thing specifying the sequence should.
>
>>  drivers/regulator/of_regulator.c       | 86 ++++++++++++++++++++++++++++++++++
>>  include/linux/regulator/of_regulator.h | 13 +++++
>>  2 files changed, 99 insertions(+)
>
> The external interface shouldn't be DT specific, the Intel people are
> busy importing all of DT into ACPI

Well, not really.

If you are referring to the pinctrl proposal discussed recently, that
was a proposal from one group at Intel and AFAICS it has been
abandoned.

> so they'll doubtless want an ACPI version.

That is possible, though, so I agree that the external interface
should not be DT-specific.
