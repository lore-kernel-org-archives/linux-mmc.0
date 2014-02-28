From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 2/4] ARM: dove: prepare new Dove DT Kconfig
	variable
Date: Fri, 28 Feb 2014 11:34:48 -0500
Message-ID: <20140228163448.GM1872@titan.lakedaemon.net>
References: <1393536486-3827-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393536486-3827-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140228015310.GC9383@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20140228015310.GC9383@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Chris Ball <chris@printf.net>, Eduardo Valentin <eduardo.valentin@ti.com>, Wim Van Sebroeck <wim@iguana.be>, Gregory Clement <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Feb 28, 2014 at 10:53:10AM +0900, Mark Brown wrote:
> On Thu, Feb 27, 2014 at 10:28:03PM +0100, Sebastian Hesselbarth wrote:
> > DT-enabled Dove will move over from ARCH_DOVE in mach-dove to MACH_DOVE in
> > mach-mvebu. As non-DT ARCH_DOVE will stay to rot for a while, add a new
> > DT-only MACH_DOVE to mmc, thermal, wdt, and asoc Kconfigs.
> 
> I'd be much happier merging this sort of stuff individually through the
> subsystems, we already have an annoying conflict here...  Is there some
> bisection problem with doing that?

shouldn't be.  Since these changes || the old with the new config
symbols.

Sebastian, can you split this up into individual patches?

thx,

Jason.
