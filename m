From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v3 04/15] MIPS: Alchemy: Don't rely on public mmc header
 to include interrupt.h
Date: Tue, 17 Jan 2017 15:50:17 +0100
Message-ID: <20170117145017.GA24215@linux-mips.org>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
 <1484313256-25993-5-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <1484313256-25993-5-git-send-email-ulf.hansson@linaro.org>
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
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mips@linux-mips.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 13, 2017 at 02:14:05PM +0100, Ulf Hansson wrote:

> The MIPS Alchemy db1300 dev board depends on interrupt.h. Explicitly
> include it instead of relying on the public mmc header host.h.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: <linux-mips@linux-mips.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> I am seeking an ack for this change as following changes for mmc in the
> series, has build-dependencies to it.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
