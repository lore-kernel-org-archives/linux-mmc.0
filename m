From: Josh Cartwright <joshc@codeaurora.org>
Subject: Re: [PATCH v10 1/3] mmc: sdhci-msm: Qualcomm SDHCI binding
 documentation
Date: Wed, 5 Mar 2014 16:10:47 -0600
Message-ID: <20140305221047.GC18529@joshc.qualcomm.com>
References: <1393961226-25618-1-git-send-email-gdjakov@mm-sol.com>
 <1393961226-25618-2-git-send-email-gdjakov@mm-sol.com>
 <CAL_JsqKJ5Jn4wb8xtqrc09kkP4dzUA6qDEkK396RW+4qFNVf+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqKJ5Jn4wb8xtqrc09kkP4dzUA6qDEkK396RW+4qFNVf+Q@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Georgi Djakov <gdjakov@mm-sol.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hey Rob-

On Wed, Mar 05, 2014 at 12:56:22AM -0600, Rob Herring wrote:
> On Tue, Mar 4, 2014 at 1:27 PM, Georgi Djakov <gdjakov@mm-sol.com> wrote:
> > +- reg-names: Should contain the following:
> > +       "hc_mem"   - Host controller register map
> > +       "core_mem" - SD Core register map
>
> reg-names should not be required and the order specified by the binding.
>
> > +- interrupts: Should contain an interrupt-specifiers for the interrupts listed in interrupt-names.
> > +- interrupt-names: Should contain the following:
> > +       "hc_irq"     - Host controller interrupt
> > +       "pwr_irq"    - PMIC interrupt
>
> Same for interrupt-names.

Could you elaborate on this a bit?  I can understand not modifying an
existing binding to make {reg,interrupt}-names required, but for
completely new bindings, why is this a problem?

Not allowing a binding to require these properties renders
platform_get_{resource,irq}_byname() useless for drivers which
exclusively use DT for enumeration.  It also makes it impossible to make
a reg entry optional (although, there probably isn't a good usecase for
this).

Thanks,
  Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
