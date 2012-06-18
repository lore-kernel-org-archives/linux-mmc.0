From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] gpio: of_get_named_gpio_flags() return -EPROBE_DEFER
 if GPIO not yet available
Date: Mon, 18 Jun 2012 09:45:24 -0600
Message-ID: <4FDF4D14.50203@wwwdotorg.org>
References: <1339927893-8842-1-git-send-email-stigge@antcom.de> <4FDE8D27.6030508@wwwdotorg.org> <4FDEF293.9080305@antcom.de> <4FDF403E.9090302@wwwdotorg.org> <4FDF4461.60707@antcom.de> <4FDF4543.6090009@wwwdotorg.org> <4FDF47D8.9000309@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FDF47D8.9000309@antcom.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, rmk+kernel@arm.linux.org.uk, ulf.hansson@stericsson.com, linus.walleij@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, aletes.xgr@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 06/18/2012 09:23 AM, Roland Stigge wrote:
> On 06/18/2012 05:12 PM, Stephen Warren wrote:
>>> Thanks for the hint! I previously also suspected sth. like this but
>>> didn't find it in v3.5-rc3. In broonie's sound.git for-next, I now
>>> finally found it.
>>>
>>> Should be easy to fix (replacing the if (... == -ENODEV) to -EPROBE_DEFER.
>>>
>>> Will you provide patches as signalled, of should I? Which branch would
>>> be the correct one to build on top?
>>
>> I'm happy either way. It'd probably be best to roll the change into your
>> patch/series so you can manage all the dependencies in one series, but
>> if you can't for some reason, I'm happy to provide a patch for this.
> 
> I should be able ;-) - is broonie's sound.git, branch for-next the
> correct one to patch against?

Yes, that's the one. Thanks.
