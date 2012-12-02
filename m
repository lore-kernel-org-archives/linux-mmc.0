From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] SDIO / PM: Add empty bus-level suspend/resume callbacks
Date: Sun, 02 Dec 2012 16:49:32 -0500
Message-ID: <87y5hgcefn.fsf@octavius.laptop.org>
References: <20120325203849.7a908e32@notabene.brown>
	<201203260029.24826.rjw@sisk.pl>
	<20121202194625.5d66e239@notabene.brown>
	<2147450.LFoExqrKEF@vostro.rjw.lan>
	<20121203065457.0bd12fc6@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20121203065457.0bd12fc6@notabene.brown> (NeilBrown's message of
	"Mon, 3 Dec 2012 06:54:57 +1100")
Sender: linux-pm-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, lkml <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, Linux PM mailing list <linux-pm@vger.kernel.org>, Thierry Reding <thierry.reding@avionic-design.de>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Sun, Dec 02 2012, NeilBrown wrote:
>> What about applying the appended patch (hopefully, the build warnings should
>> be fixed properly this time)?
>
> Looks good to me - thanks!

Thanks, both of you, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
