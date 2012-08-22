From: Mitch Bradley <wmb-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Wed, 22 Aug 2012 07:09:42 -1000
Message-ID: <50351256.60507@firmworks.com>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org>
 <CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com>
 <87k3ws5uhs.fsf@octavius.laptop.org> <201208211208.49987.arnd@arndb.de>
 <87393g5mic.fsf@octavius.laptop.org> <5033A34E.7040201@gmail.com>
 <87pq6k46jg.fsf@octavius.laptop.org> <5033B0F0.7050506@gmail.com>
 <CAJuYYwR+oCQUcgoy6ZuHp0XAa+EAj9d-FvLtwsQcP3muFMrKLA@mail.gmail.com>
 <20120822055151.GT24242@S2101-09.ap.freescale.net>
 <877gsr5iz1.fsf@octavius.laptop.org>
 <CAJuYYwQz00ZzB5MxRG66XEPZApAtS6bwJAafmw3b=7DD7u+Crg@mail.gmail.com>
 <87y5l7421h.fsf@octavius.laptop.org>
 <CAJuYYwQLUs5qb8NqtPf3=ytNHJ_VdnN8Z4yWwyk2+OTftdWFXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAJuYYwQLUs5qb8NqtPf3=ytNHJ_VdnN8Z4yWwyk2+OTftdWFXw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Thomas,

On 8/22/2012 2:04 AM, Thomas Abraham wrote:
> On 22 August 2012 16:38, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org> wrote:
>> Hi Thomas,
>>
>> On Wed, Aug 22 2012, Thomas Abraham wrote:
>>>> This matches Mitch's last suggestion exactly -- I think we're all agreed
>>>> on these properties now.  The only remaining question is how to handle
>>>> the pinctrl for CD in Thomas's case.
>>>
>>> Hi Chris,
>>>
>>> For sdhci-s3c driver, the 'broken-cd' and 'cd-gpios' bindings are
>>> sufficient. But, are drivers free to use implementation specific
>>> behavior when using these bindings. Or do we strictly adhere to the
>>> table which Shawn has listed. For sdhci-s3c driver, I would like to
>>> deviate from the "implication" column listed above.
>>
>> I'd rather you use the implications described above for the names
>> described above; there's not much point in defining named behaviors
>> across the subsystem if they're actually different in each driver.
> 
> Ok.
> 
>>
>> But I think you can still use driver-internal properties that change the
>> interpretation of those names in a documented way.  If the meaning of
>> cd-gpios is modified when coupled with your "samsung,sdhci-cd-external",
>> that's okay with me.  That should cover all the cases you need until you
>> migrate to using pinctrl, right?  So, you could immediately support:
>>
>> none          -> currently "samsung,sdhci-cd-internal"
>> broken-cd     -> currently "samsung,sdhci-cd-none"
>> cd-gpios      -> currently "samsung,sdhci-cd-gpios"
>> non-removable -> currently "samsung,sdhci-cd-permanent"
>> cd-gpios + samsung,sdhci-cd-external -> currently "samsung,sdhci-cd-external"
>>
>> How does that sound?
> 
> Not quite there yet. It is not possible to leave out cd-gpios for
> "samsung,sdhci-cd-internal" since the current Samsung pinmux
> configuration piggybacks on gpio dt binding.


Sorry to interject on a topic that seems to have already been decided,
but I'm confused by one thing and would like clarification.  I
understand that you need to use a GPIO-style specifier as a surrogate
for a pinmux specification - that much is clear.  What is not clear is
why it's necessary to (ab)use the name "cd-gpios" for it.

Why not use a different property name, e.g. "samsung,cd-pinmux-gpio =
<gpio-specifier>" for the "cd-gpios + samsung,sdhci-cd-internal" case?
Then both "samsung,sdhci-cdi-internal" and "samsung,sdhci-cd-external"
could go away.  There would only be one system-dependent property
"samsung,cd-pinmux-gpio" whose name would make it clear that it's
conflating pinmuxing and gpios.

I think the scheme I propose would be clearer, less likely to confuse
other people who try to use the driver as a model, require less
hand-waving in the documentation, and easier to change to a proper
pinmuxing scheme should that become available later.


 Can we use the following
> instead.
> 
> none               -> currently "samsung,sdhci-cd-none"
> broken-cd        -> currently "samsung,sdhci-cd-none"
> cd-gpios          -> currently "samsung,sdhci-cd-gpios"
> non-removable -> currently "samsung,sdhci-cd-permanent"
> cd-gpios + samsung,sdhci-cd-internal -> currently "samsung,sdhci-cd-internal"
> 
> Thanks Chris.
> 
> Regards,
> Thomas.
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
