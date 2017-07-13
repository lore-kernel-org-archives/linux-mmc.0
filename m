From: Ye Xiaolong <xiaolong.ye-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [kbuild-all] [PATCH 3/3] ARM: dts: iwg20m: Add MMCIF0 support
Date: Thu, 13 Jul 2017 16:46:00 +0800
Message-ID: <20170713084600.GA1787@yexl-desktop>
References: <1499853805-5915-4-git-send-email-chris.paterson2@renesas.com>
 <201707130850.0py1QazG%fengguang.wu@intel.com>
 <20170713075414.GF5580@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170713075414.GF5580-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Paterson <chris.paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org, Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 07/13, Simon Horman wrote:
>On Thu, Jul 13, 2017 at 08:25:56AM +0800, kbuild test robot wrote:
>> Hi Chris,
>> 
>> [auto build test ERROR on renesas/next]
>> [also build test ERROR on next-20170712]
>> [cannot apply to v4.12]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>> 
>> url:    https://github.com/0day-ci/linux/commits/Chris-Paterson/Add-MMCIF0-support-for-r8a7743-iwg20m/20170713-042814
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
>> config: arm-at91_dt_defconfig (attached as .config)
>> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
>> reproduce:
>>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=arm 
>> 
>> All errors (new ones prefixed by >>):
>> 
>> >> Error: arch/arm/boot/dts/r8a7743-iwg20m.dtsi:40.1-5 Label or path pfc not found
>>    FATAL ERROR: Syntax error parsing input tree
>
>This seems to be a false positive. The node in question is present in
>the devel branch which is the base of these changes.

Thanks for the feedback, we'll update 0day's configuration accordingly.

Thanks,
Xiaolong
>
>
>_______________________________________________
>kbuild-all mailing list
>kbuild-all-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
>https://lists.01.org/mailman/listinfo/kbuild-all
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
