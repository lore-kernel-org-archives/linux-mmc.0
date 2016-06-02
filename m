From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 01/20] x86, intel: Introduce macros for Intel family
 numbers
Date: Thu, 2 Jun 2016 08:57:15 +0200
Message-ID: <20160602065715.GA10803@pd.tnic>
References: <20160602001157.D8BE59D7@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160602001157.D8BE59D7@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave@sr71.net>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@linux.intel.com, adrian.hunter@intel.com, ak@linux.intel.com, luto@kernel.org, dvhart@infradead.org, dougthompson@xmission.com, edubezval@gmail.com, hpa@zytor.com, mingo@redhat.com, jacob.jun.pan@linux.intel.com, kan.liang@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, mchehab@osg.samsung.com, peterz@infradead.org, platform-driver-x86@vger.kernel.org, rafael.j.wysocki@intel.com, rajneesh.bhardwaj@intel.com, souvik.k.chakravarty@intel.com, srinivas.pandruvada@linux.intel.com, eranian@google.com, tglx@linutronix.de, tony.luck@intel.com, ulf.hansson@linaro.org, viresh.kumar@linaro.org, vishwanath.somayaji@intel.com, zheng.z.yan@intel.com, rui.zhang@intel.com
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 01, 2016 at 05:11:57PM -0700, Dave Hansen wrote:
> +#define INTEL_FAM6_MODEL_CORE_YONAH		0x0E
> +#define INTEL_FAM6_MODEL_CORE2_MEROM		0x0F

That "MODEL_" part looks redundant too IMO - you could simply do

INTEL_FAM6_NEHALEM and
INTEL_FAM6_SKYLAKE_DESKTOP
...

and so on and it is still clear what it is.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
