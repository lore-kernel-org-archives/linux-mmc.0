From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 05/29] regulator: use IS_ERR_OR_NULL() instead of
 open-coding
Date: Fri, 18 May 2012 16:04:19 +0100
Message-ID: <20120518150417.GA4039@opensource.wolfsonmicro.com>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-6-git-send-email-g.liakhovetski@gmx.de>
 <20120503153239.GN3955@opensource.wolfsonmicro.com>
 <20120518085749.GE24355@linux-sh.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120518085749.GE24355@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 18, 2012 at 05:57:50PM +0900, Paul Mundt wrote:
> On Thu, May 03, 2012 at 04:32:39PM +0100, Mark Brown wrote:
> > On Thu, May 03, 2012 at 05:05:34PM +0200, Guennadi Liakhovetski wrote:

> > > -	if (regulator == NULL || IS_ERR(regulator))
> > > +	if (IS_ERR_OR_NULL(regulator))

> > The bigger question here is why we're accepting NULL in the first place.

> I'm not sure about the regulator case, but it's been useful to support
> passing NULL around in the clock framework case. There are plenty of
> cases where a struct clk is optional and if we fail to find the clock we
> just set clk to NULL and continue on without having to constantly check
> the value of the clk pointer, which helps considerably when you consider
> the number of clk_enable/disable() pairs some drivers have.

> Presumably the same applies for regulators?

This is checking the value of regulator_get(), NULL is a perfectly valid
regulator value to get passed back.

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPtmTLAAoJEBus8iNuMP3d3/8P/jBzJ8oB7uOI3WI+Af3dEZrk
hfpFlm546LaGHs1Xz8QO4GmGFHF0XbqSB666K+k/tU9cBRQou/6LXROIx08hjgir
fEhGTg7YZu6XsbxEojedoou3Ltq12d0jJAGCmYzTUDxLDV5qHLlAuwI+qYMKbm4x
GWD/gT4w/A6TmS7sigvGlnrIKx/nyeGd5ls2n9JQhpQeUk+p+iVORSw52Ynv245C
FYIoI63Ug/SVizrrKvTjiBBzpKqatt64FooA4DeZhSBgfzMo4abruT8rHC++At28
0RWxSRKKIsT4N11T1vXl6NRVDmM5N6z/BQQlzc9RZgoeNTznGqYip3Gzxb3BsgkU
ZwTojhHqFzaLX+jUD2ZvdpemX9VJh+rSCkyULOBwR2tIopMlG5ES2Xtsqjsy0DQM
+TlQHxByziszYN9ybwFbJBJgkaRAAXLJ2MN0Z+8lLrMjcM7sg0dc0F282un9heD9
Mbtsqzk8hGPjF2cJ1lGnWqvrPnNjz8jKoN+k1ABt41uo+3iySdpOA3uTryenRdv8
T9Eo5837AJNAqADtOodZ11tIaTjgUN1JbNHH+x1eD/zJgD0ZSSh6ybeNzaLtiTon
gdp5KVzDssNV0eB4+BTTJ+GIJ7kqAyx70TFDsb760NN4bQt0f/v/1xqD8DwyVd9n
GdKEIlfAduX6kPA0YzTn
=32gs
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
