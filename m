From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/6] mmc: slot-gpio: Record GPIO descriptors instead of
 GPIO numbers
Date: Fri, 14 Mar 2014 12:23:54 +0200
Message-ID: <5322D8BA.8060305@intel.com>
References: <1394456564-13783-1-git-send-email-adrian.hunter@intel.com>	<1394456564-13783-2-git-send-email-adrian.hunter@intel.com> <CACRpkdaHRsASr1jxPcUb+8G25BpOO0kB9mXFi_gocJ9cWmYDDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45156 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752693AbaCNKYj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 14 Mar 2014 06:24:39 -0400
In-Reply-To: <CACRpkdaHRsASr1jxPcUb+8G25BpOO0kB9mXFi_gocJ9cWmYDDw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ulf Hansson <ulf.hansson@stericsson.com>

On 14.03.2014 11:06, Linus Walleij wrote:
> On Mon, Mar 10, 2014 at 2:02 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>> In preparation for adding a descriptor-based CD GPIO
>> API, switch from recording GPIO numbers to recording
>> GPIO descriptors.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Certainly this makes things look better from a GPIO POV
> so Acked-by.
> 
> However:
> 
> (...)
>> +       ctx->ro_gpio = gpio_to_desc(gpio);
> (...)
>> +       ctx->cd_gpio = gpio_to_desc(gpio);
> 
> How much harder would it be to switch the platforms using this
> MMC driver to pass GPIO descriptors using the gpiod_lookup_table
> in affected platforms (or device tree or ACPI) and then use
> devm_gpiod_get[_index]() in probe()?

There are 10 drivers plus users of mmc_of_config(), so too much work for me
right now.  Also parts that relate to device-tree are outside my sphere.

> This can certainly be step 2, but that is where we want to go with
> the GPIO clean-up work in the long run.

Perhaps Ulf or Guennadi would be interested.

