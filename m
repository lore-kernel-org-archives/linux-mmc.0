From: Ben Dooks <ben@trinity.fluff.org>
Subject: Re: [PATCH 1/3] mmc: block: add block number limitation flag for
 lultiple block read
Date: Fri, 30 May 2014 12:46:54 +0100
Message-ID: <20140530114654.GF6241@trinity.fluff.org>
References: <87ppivpn25.wl%kuninori.morimoto.gx@renesas.com>
 <87oayfpn14.wl%kuninori.morimoto.gx@renesas.com>
 <538864C1.2040203@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <538864C1.2040203@samsung.com>
Sender: linux-sh-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, May 30, 2014 at 08:00:17PM +0900, Jaehoon Chung wrote:
> Hi, Kuninori.
> 
> Subject has the typo. lultiple -> multiple?
> I didn't know why you need this patch. Would you use the MMC_CAP2_NO_MULTI_READ?
> And I think...it's not good that used the card's capability flags to fix your H/W bug.

If you do that, then there is around a 8-10x performance penalty.

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.

