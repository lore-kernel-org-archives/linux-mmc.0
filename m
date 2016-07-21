From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH V8 2/2] mmc: OCTEON: Add host driver for OCTEON MMC
 controller.
Date: Thu, 21 Jul 2016 15:46:04 +0200
Message-ID: <20160721134603.GA25689@linux-mips.org>
References: <57853474.9050108@cavium.com>
 <578E71E6.2020700@caviumnetworks.com>
 <CAPDyKFqb-7LLM0XPtVWj1qHib991E2dHt+6W0UPgbXnukGkmXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqb-7LLM0XPtVWj1qHib991E2dHt+6W0UPgbXnukGkmXA@mail.gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Steven J. Hill" <Steven.Hill@caviumnetworks.com>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jul 19, 2016 at 11:19:43PM +0200, Ulf Hansson wrote:

> > Has anyone reviewed the driver or have any comments? Thanks.
> 
> Sorry I need more time, been partly out of office lately.
> I intend to review this prior rc1 is out, but no promises.
> 
> Kind regards
> Uffe

Ulf,

if you decide to accept this patch, could you also push the bindings
patch ("[V8,1/2] mmc: OCTEON: Add DT bindings for OCTEON MMC controller.")
upstream?  I think they should be merged together.

Thanks,

  Ralf
