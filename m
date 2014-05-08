From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v10 00/15] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Thu, 08 May 2014 13:05:22 +0200
Message-ID: <536B64F2.3010901@redhat.com>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com> <20140506170437.5739.402@quantum>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDRZXY4CYYORB7GJVWNQKGQEHBGSM4Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140506170437.5739.402@quantum>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Cc: =?UTF-8?B?RGF2aWQgTGFuemVuZMO2cmZlcg==?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 05/06/2014 07:04 PM, Mike Turquette wrote:
> Quoting Hans de Goede (2014-05-02 08:57:14)
>> The first 2 patches are depenencies which should go in through the clk tree,
>> Mike can you pick these 2 up please ?  :
> 
> Taken into clk-next.

Thanks!

>> "clk: sunxi: factors: automatic reparenting support"
>> Is uncontroversial and has been favorably reviewed by various people.
>>
>> "clk: sunxi: Implement MMC phase control"
>> Is somewhat more controversial as there has been lots of discussion about
>> adding a generic phase control method to the clk framework. The problem is
>> that there has been a lot of talk about such a generic phase control method
>> but not a single patch. Therefor I would like to move forwards with using
>> a platform specific method for now. I hereby promise that once we've a generic
>> method I'll write patches to convert the sunxi code to that method.
> 
> Thanks for the promise. I will hold you to it once the set_phase api is
> sorted ;-)

Hehe, no problem when I promise something I expect to be kept to it.

Regards,

Hans
