From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v1 1/1] mmc: sd: Handle SD3.0 cards not supporting  UHS-I bus speed mode
Date: Mon, 22 Aug 2011 09:20:45 -0400
Message-ID: <m2mxf1fuqa.fsf@bob.laptop.org>
References: <1312955161-24844-1-git-send-email-subhashj@codeaurora.org>
	<m2k4ajpran.fsf@bob.laptop.org>
	<3f99dd036fb7c56c252e1dd27ccc965a.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <3f99dd036fb7c56c252e1dd27ccc965a.squirrel@www.codeaurora.org>
	(Subhash Jadavani's message of "Mon, 22 Aug 2011 02:44:39 -0700
	(PDT)")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, "Nath, Arindam" <arindam.nath@amd.com>
List-Id: linux-mmc@vger.kernel.org

Hi Subhash,

On Mon, Aug 22 2011, Subhash Jadavani wrote:
> status[13] = 2 => High speed mode
> status[13] = 1 => Default speed mode
>
> If you want, i can add 2 more macros for HS and DS modes. Do you want me
> to define these macros within mmc_read_switch() or under sd_switch_caps
> struct in include/linux/mmc/card.h file?

Under the struct sounds good.

How about status[13] itself?  Could we add macros for the names of the
status bits, as we do for e.g. the ext_csd[*] fields in mmc.h?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
