From: "Jon Medhurst (Tixy)" <jon.medhurst@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Do not release spinlock in request_end
Date: Thu, 13 Oct 2011 16:59:52 +0100
Message-ID: <1318521592.2090.16.camel@linaro1>
References: <1318342001-26955-1-git-send-email-ulf.hansson@stericsson.com>
	<20111013142914.GZ21648@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20111013142914.GZ21648@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Thu, 2011-10-13 at 15:29 +0100, Russell King - ARM Linux wrote:
> On Tue, Oct 11, 2011 at 04:06:41PM +0200, Ulf Hansson wrote:
> > The patch "mmc: core: move ->request() call from atomic context",
> > is the reason to why this change is possible. This simplifies the
> > error handling code execution path quite a lot and potentially also
> > fixes some error handling hang problems.
> > 
> > Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> 
> This doesn't look right:
> 
> void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
> {
>         if (err && cmd->retries) {
>                 host->ops->request(host, mrq);
> 
> So, not dropping the spinlock results in calling the request function
> with the spinlock held - and as the request function then goes on to
> lock the spinlock, we will deadlock.

Indeed, deadlock behaviour at this point is what I see with this patch
on a Versatile Express board running 3.0-rc9.

-- 
Tixy
