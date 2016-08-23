From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] sdhci: Add quirk and device tree parameter to force SD
 test mode
Date: Tue, 23 Aug 2016 09:22:29 +0300
Message-ID: <684dd3fb-15ac-fa84-2f1e-89f379b5149a@intel.com>
References: <1471906531-28668-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471906531-28668-1-git-send-email-zach.brown-acOepvfBmUk@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 23/08/16 01:55, Zach Brown wrote:
> From: Jaeden Amero <jaeden.amero-acOepvfBmUk@public.gmane.org>
> 
> On some devices, CD is broken so that we must force the SDHCI into test
> mode and set CD, so that it always detects an SD card as present.
> 
> In order to get a device with broken CD working, we had previously
> always set the SDHCI into test mode. Unfortunately, this had the side
> effect of making all SD cards used with our Linux kernels undetectable
> and non-removable.
> 
> By making this "SD test mode" setting optional via a quirk, we can avoid
> this side effect for devices other than the device with broken CD.
> Additionally, we add a device parameter to sdhci-pltfm to allow all
> SDHCI drivers to enable this quirk.

Generally new quirks are not acceptable, but I don't see how test mode helps
very much since you still don't get any card detection events.  If you
really need test mode, please explain more about how it helps (as opposed to
polling for example).


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
