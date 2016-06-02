From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 01/20] x86, intel: Introduce macros for Intel family
 numbers
Date: Thu, 2 Jun 2016 14:45:57 -0700
Message-ID: <20160602214557.GB1975@f23x64.localdomain>
References: <20160602001157.D8BE59D7@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160602001157.D8BE59D7@viggo.jf.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Dave Hansen <dave@sr71.net>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@linux.intel.com, adrian.hunter@intel.com, ak@linux.intel.com, luto@kernel.org, bp@alien8.de, dougthompson@xmission.com, edubezval@gmail.com, hpa@zytor.com, mingo@redhat.com, jacob.jun.pan@linux.intel.com, kan.liang@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, mchehab@osg.samsung.com, peterz@infradead.org, platform-driver-x86@vger.kernel.org, rafael.j.wysocki@intel.com, rajneesh.bhardwaj@intel.com, souvik.k.chakravarty@intel.com, srinivas.pandruvada@linux.intel.com, eranian@google.com, tglx@linutronix.de, tony.luck@intel.com, ulf.hansson@linaro.org, viresh.kumar@linaro.org, vishwanath.somayaji@intel.com, zheng.z.yan@intel.com, rui.zhang@intel.com
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 01, 2016 at 05:11:57PM -0700, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> If you are cc'd on this code, please check _your_ code vs. the
> model list in "intel-family.h".  Please make sure you have all
> the models listed that you intend to.
> 
> Problem:
> 
> We have a boatload of open-coded family-6 model numbers.  Half of
> them have these model numbers in hex and the other half in
> decimal.  This makes grepping for them tons of fun, if you were
> to try.
> 
> Solution:
> 
> Consolidate all the magic numbers.  Put all the definitions in
> one header.
> 
> The names here are closely derived from the comments describing
> the models from arch/x86/events/intel/core.c.  We could easily
> make them shorter by doing things like s/SANDYBRIDGE/SNB/, but
> they seemed fine even with the longer versions to me.
> 
> Do not take any of these names too literally, like "DESKTOP"
> or "MOBILE".  These are all colloquial names and not precise
> descriptions of everywhere a given model will show up.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Darren Hart <dvhart@infradead.org>

For platform/drivers/x86:

Magic number to macro mapping verified.

Acked-by: Darren Hart <dvhart@linux.intel.com>

-- 
Darren Hart
Intel Open Source Technology Center
