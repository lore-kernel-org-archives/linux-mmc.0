From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Sat, 11 Dec 2010 09:53:04 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012110950210.10743-100000@netrider.rowland.org>
References: <AANLkTi=67vtfiQMQHTijx6DMo2y2-b9BfOq1nx-zG7TU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=67vtfiQMQHTijx6DMo2y2-b9BfOq1nx-zG7TU@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>
List-Id: linux-mmc@vger.kernel.org

On Sat, 11 Dec 2010, Ohad Ben-Cohen wrote:

> By allowing nested suspend sequences we even squeeze some more power
> by suspending devices earlier, and saving some CPU cycles (due to the
> avoided context switches), so it sounds like a win-win...

There's a trade-off, and it's not clear which approach is best.

> But of course I may be overlooking a real problem this may pose.. I
> haven't spotted any, but it does feel like a significant behavior
> change, hence the cautious approach :)

I don't think there would be any real problems.  Hard to know for sure 
without trying it...

Alan Stern
