From: "Michael K. Johnson" <johnsonm@danlj.org>
Subject: Re: [PATCH v3 1/3] mmc: sdhci: Add PLL Enable support to internal
 clock setup
Date: Thu, 15 Aug 2019 08:04:32 -0400
Message-ID: <20190815120432.GA20438@people.danlj.org>
References: <20190726020746.GB12042@people.danlj.org>
 <acc74e9e-ca41-a5dd-780a-615745d70101@intel.com>
 <20190812225611.GA30758@people.danlj.org>
 <d6432410-6431-efdb-4e28-a601493e4916@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d6432410-6431-efdb-4e28-a601493e4916@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 15, 2019 at 02:27:44PM +0300, Adrian Hunter wrote:
> On 13/08/19 1:56 AM, Michael K. Johnson wrote:
> > The GL9750 and GL9755 chipsets, and possibly others, require PLL Enable
> > setup as part of the internal clock setup as described in 3.2.1 Internal
> > Clock Setup Sequence of SD Host Controller Simplified Specification
> > Version 4.20.  This changes the timeouts to the new specification of
> > 150ms for each step and is documented as safe for "prior versions which
> > do not support PLL Enable."
> > 
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
> 
> Did you mean for this patch to be "From:" Ben Chuang because otherwise
> "Co-developed-by" the author is redundant.

Ben wrote the code and is the primary author. I helped with some
changes to bring it closer to normal style, so I have definitely
been a secondary co-developer. Ben's corporate email server adds a
generic confidentiality notice outside his control, and we were
informed that with that header on the email the patches could not
be accepted.  We developed it in a git repository, so that I have
not been "tainted" by the automatic confidentiality notice, and
at Ben's request I have posted the work. To credit me as primary
author would be fundamentally incorrect.

Are you saying that this work cannot be accepted until Ben chooses
an alternative email provider besides his corporate email in order
to avoid the spurious confidentiality notice, such that he is the
sender of the email?
