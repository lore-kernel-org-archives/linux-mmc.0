From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 2/2] mmc: fix integer assignments to pointer
Date: Tue, 23 Aug 2011 22:38:03 +0200
Message-ID: <20110823203803.GA17148@merkur.ravnborg.org>
References: <1314114363-6767-1-git-send-email-svenkatr@ti.com> <1314114363-6767-3-git-send-email-svenkatr@ti.com> <m27h643x8k.fsf@bob.laptop.org> <20110823172851.GB1784@leaf> <874o18m2cn.fsf@blp.benpfaff.org> <20110823181359.GB3418@leaf> <m2mxf02d9h.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <m2mxf02d9h.fsf@bob.laptop.org>
Sender: linux-sparse-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Josh Triplett <josh@joshtriplett.org>, blp@cs.stanford.edu, Venkatraman S <svenkatr@ti.com>, linux-mmc@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

> 
> I'm still a little confused -- the {0} or memset(0, struct ..);
> formations are used often in the kernel, even with pointers involved.
> Is the warning (Wnon_pointer_null) run against the kernel by default,
> or did Venkatraman add it manually?  If default, is it catching bugs?

Did a quick "allnoconfig" build. With this minimal build the warning only triggered three times.
So a lot of these has been fixed already.

	Sam
