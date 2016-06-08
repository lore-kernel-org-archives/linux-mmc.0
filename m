From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 01/20] [v2] x86, intel: Introduce macros for Intel family
 numbers
Date: Wed, 8 Jun 2016 13:01:47 +0200
Message-ID: <20160608110147.GA32077@gmail.com>
References: <20160603001927.F2A7D828@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160603001927.F2A7D828@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave@sr71.net>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, jacob.jun.pan@intel.com, dave.hansen@linux.intel.com, adrian.hunter@intel.com, ak@linux.intel.com, luto@kernel.org, bp@alien8.de, dvhart@infradead.org, dougthompson@xmission.com, edubezval@gmail.com, hpa@zytor.com, mingo@redhat.com, jacob.jun.pan@linux.intel.com, kan.liang@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, mchehab@osg.samsung.com, peterz@infradead.org, platform-driver-x86@vger.kernel.org, rafael.j.wysocki@intel.com, rajneesh.bhardwaj@intel.com, souvik.k.chakravarty@intel.com, srinivas.pandruvada@linux.intel.com, eranian@google.com, tglx@linutronix.de, tony.luck@intel.com, ulf.hansson@linaro.org, viresh.kumar@linaro.org, vishwanath.somayaji@intel.com, rui.zhang@intel.com
List-Id: linux-mmc@vger.kernel.org


* Dave Hansen <dave@sr71.net> wrote:

> 
> Changes from v1:
>  * added acks from a few folks
>  * Took the redundant "MODEL_" out of the macro names (Suggested
>    by Borislav Petkov and acked by others)
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> If you are cc'd on this code, please check _your_ code vs. the
> model list in "intel-family.h".  Please make sure you have all
> the models listed that you intend to.
> 
> Also, rather than trickling these in via all the various
> maintainers, should these just get pulled in to the x86 tree in
> one go?
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
> These have all been compile-tested.  I also made a stab at
> dumping .o files and looking for unexpected deltas when I was
> just replacing magic numbers with equivalent macros.

So I've picked up this series and restructured it: I've created a single patch 
that creates intel-family.h and have put it into x86/urgent. This eliminated 
dependencies and allowed some of the patches to be queued in their natural trees, 
in particular the 7 perf patches.

Thanks,

	Ingo
