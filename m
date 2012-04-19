From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 8/8] ARM: omap_hsmmc: remove platform data dma_mask and
	initialization
Date: Thu, 19 Apr 2012 18:43:32 +0100
Message-ID: <20120419174332.GY25053@n2100.arm.linux.org.uk>
References: <CANrkHUajRzoCp7K8L3cJArWN3xdqpft8L4k-o4gFTRTo8nmhmg@mail.gmail.com> <20120418152956.GP25053@n2100.arm.linux.org.uk> <CANrkHUYvKdBUZh9UmWcE30ywAAiqhN-KcnSAE2T56WJLFPX1gA@mail.gmail.com> <20120418194224.GS25053@n2100.arm.linux.org.uk> <20120418200214.GP21106@atomide.com> <20120418202447.GT25053@n2100.arm.linux.org.uk> <20120418210142.GR21106@atomide.com> <20120418211606.GU25053@n2100.arm.linux.org.uk> <20120418213642.GV25053@n2100.arm.linux.org.uk> <20120419013914.GV21106@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120419013914.GV21106@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, "T Krishnamoorthy, Balaji" <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Apr 18, 2012 at 06:39:14PM -0700, Tony Lindgren wrote:
> Cool, you almost got it. Got it working for n800 and 770 with the following
> patch. Only extremely light testing done now so careful with this patch too..
> 
> Had to hack in support for the src_port and dst_port that's needed for
> omap_set_dma_src/dest_params on omap1.

What's the relationship between these ports and the DMA request signal?
Is there a document which describes this?
