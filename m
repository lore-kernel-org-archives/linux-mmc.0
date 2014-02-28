From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ARM: dove: prepare new Dove DT Kconfig
	variable
Date: Fri, 28 Feb 2014 10:53:10 +0900
Message-ID: <20140228015310.GC9383@sirena.org.uk>
References: <1393536486-3827-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393536486-3827-3-git-send-email-sebastian.hesselbarth@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3770382774025675570=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1393536486-3827-3-git-send-email-sebastian.hesselbarth@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Liam Girdwood <lgirdwood@gmail.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Wim Van Sebroeck <wim@iguana.be>, Gregory Clement <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--===============3770382774025675570==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tUxbtEzdJc4sX0sj"
Content-Disposition: inline


--tUxbtEzdJc4sX0sj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2014 at 10:28:03PM +0100, Sebastian Hesselbarth wrote:
> DT-enabled Dove will move over from ARCH_DOVE in mach-dove to MACH_DOVE in
> mach-mvebu. As non-DT ARCH_DOVE will stay to rot for a while, add a new
> DT-only MACH_DOVE to mmc, thermal, wdt, and asoc Kconfigs.

I'd be much happier merging this sort of stuff individually through the
subsystems, we already have an annoying conflict here...  Is there some
bisection problem with doing that?

--tUxbtEzdJc4sX0sj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTD+wCAAoJELSic+t+oim9SEEP/1dJP3BuVMcQbukxUy5f13cO
42+7SE32MruC+GG4JGjZnatJWYyQJp0kqqrcTSgIMDzeobR+Pw4yKcKuZ+jWOVyO
Wj4auHvwgNl19l8spX3Un78yUkOxQ9pleauSNz6TnjJwdgYf04LsZD8o4D9bgWIX
ALbMtaK9wvHZv74gILwTFSS+p9DMNOqaZv8bNh62fU8+beVHNRboYQ9RVeVIoQvR
AtVHD1eo+LrNjQrsSqEFJ5qWKOpxBdaOXXLzcPjosMjkQBG9nvgGHnG8ttXWHzCl
9F+6yHVGgKVpD0xbEmk6rv6z8DuJLuTCJYS6OxV4YT1/tOHmcF3ZSsTyxCstxhCb
iQyH8Apu+OPzHbpBjtgdj1bcQAs+I7IgQgDJ+Y3UJ99tsk3DV3rX6DvaJCzUdUVZ
SGej68k03AZ1EkP9lwQcjjO529ysu44SYVMH/zK0a0roAcAfbzvzwaE70rlEEmsb
RQpDhwFc4hDknZJc9JY+FgfyWs7Umxru6bVnycfFL6bQOtEgtFT2N4vpLgybko80
e+oShZ0VdZSqdUi0DvLDd/O64A0angoiBQ8MzDbQMFoIe4nm0uV1yOR1NO0B1vYu
cOjFewsTB+FC+mOQCzJ8CARQxdyDaAfLVXhLnFL5BtUn0c/TK3u28hAGItJocAow
PRSrWqdlY+LRnAJBUtz+
=XrZQ
-----END PGP SIGNATURE-----

--tUxbtEzdJc4sX0sj--

--===============3770382774025675570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3770382774025675570==--
