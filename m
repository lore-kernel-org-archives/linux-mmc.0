From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 01/20] [v2] x86, intel: Introduce macros for Intel family numbers
Date: Fri, 03 Jun 2016 02:38:59 +0200
Message-ID: <3618590.bN2s1CDUs5@vostro.rjw.lan>
References: <20160603001927.F2A7D828@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59540 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750833AbcFCAfJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Jun 2016 20:35:09 -0400
In-Reply-To: <20160603001927.F2A7D828@viggo.jf.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dave Hansen <dave@sr71.net>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, jacob.jun.pan@intel.com, dave.hansen@linux.intel.com, adrian.hunter@intel.com, ak@linux.intel.com, luto@kernel.org, bp@alien8.de, dvhart@infradead.org, dougthompson@xmission.com, edubezval@gmail.com, hpa@zytor.com, mingo@redhat.com, jacob.jun.pan@linux.intel.com, kan.liang@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, mchehab@osg.samsung.com, peterz@infradead.org, platform-driver-x86@vger.kernel.org, rafael.j.wysocki@intel.com, rajneesh.bhardwaj@intel.com, souvik.k.chakravarty@intel.com, srinivas.pandruvada@linux.intel.com, eranian@google.com, tglx@linutronix.de, tony.luck@intel.com, ulf.hansson@linaro.org, viresh.kumar@linaro.org, vishwanath.somayaji@intel.com, rui.zhang@intel.com

On Thursday, June 02, 2016 05:19:27 PM Dave Hansen wrote:
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

Yes, please.

