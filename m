From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: sdhci-tegra and power-gpios
Date: Mon, 01 Oct 2012 10:05:55 -0600
Message-ID: <5069BF63.20104@wwwdotorg.org>
References: <87vceunrzi.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87vceunrzi.fsf-DGHOrqG7t0YzNDMTQreKSUB+6BGkLq7r@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Pavan Kunapuli <pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 10/01/2012 09:15 AM, Chris Ball wrote:
> Hi Stephen, tegra folks,
> 
> sdhci-tegra uses a power-gpios property in the DT:
> 
>         sdhci@c8000400 {
...
>                 power-gpios = <&gpio 70 0>; /* gpio PI6 */
...
> It's quite easy to set up a regulator and attach it to an MMC node:
...
>         sdhci@c8000400 {
...
> 		vmmc-supply = <&vmmc1>;
...
> Any interest in making this change?

Yes, it's certainly something we should be doing. Most Tegra boards will
only have all the regulators defined in device tree for the first time
in kernel 3.7, and so we've been holding off making any of the client
nodes use regulators because of that. Now that we have all the
regulators defined, I do hope we will quickly move to using them for
SDHCI. Pavan (now CC'd) will hopefully be doing this.
