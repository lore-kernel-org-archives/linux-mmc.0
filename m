From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 2/5] mmc: tmio: add a flag to prohibit access to registers above 0xff
Date: Tue, 8 Mar 2011 16:34:34 +0900
Message-ID: <20110308073434.GB13892@linux-sh.org>
References: <Pine.LNX.4.64.1103071937010.29543@axis700.grange> <Pine.LNX.4.64.1103071944200.29543@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1103071944200.29543@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

On Mon, Mar 07, 2011 at 07:47:51PM +0100, Guennadi Liakhovetski wrote:
> On some implementations there are no registers above 0xff and any
> access to them mirrors to registers at addresses with bit 8 masked
> out, which leads to malfunction. Add a flag to prevent such accesses.

I'm not sure I really see what the point of the flag is, surely you can
derive all of this information already from the I/O resource for the
register window in question?
