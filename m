From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 00/27] add
	pm_runtime_last_busy_and_autosuspend() helper
Date: Thu, 25 Sep 2014 09:22:01 -0500
Message-ID: <20140925142201.GD28045@saruman>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
 <6374313.I12loOK9hA@vostro.rjw.lan>
 <20140924201558.GX17997@saruman>
 <2322320.9rETJijE2n@vostro.rjw.lan>
 <20140924203219.GZ17997@saruman> <20140925075718.GW24663@intel.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0473778243=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20140925075718.GW24663@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Vinod Koul <vinod.koul@intel.com>
Cc: linux-wireless@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, patches@opensource.wolfsonmicro.com, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Chris Ball <chris@printf.net>, dri-devel@lists.freedesktop.org, Marcin Wojtas <mw@semihalf.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Herrmann <dh.herrmann@gmail.com>, Shinya Kuribayashi <skuribay@pobox.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Jingoo Han <jg1.han@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Jani Nikula <jani.nikula@intel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Alan Stern <stern@rowland.harvard.edu>, Ben Skeggs <bskeggs@redhat.com>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Wolfram Sang <wsa@the-dreams>
List-Id: linux-mmc@vger.kernel.org

--===============0473778243==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pZs/OQEoSSbxGlYw"
Content-Disposition: inline

--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 01:27:18PM +0530, Vinod Koul wrote:
> On Wed, Sep 24, 2014 at 03:32:19PM -0500, Felipe Balbi wrote:
> > > > > OK, I guess this is as good as it gets.
> > > > >=20
> > > > > What tree would you like it go through?
> > > >=20
> > > > Do we really need this new helper ? I mean, the very moment when we
> > > > decide to implement ->runtime_idle() we will need to get rid of this
> > > > change. I wonder if it's really valid...
> > >=20
> > > I'm not sure I'm following?  This seems to simply implement what driv=
ers
> > > have been doing already as one function.  Why would it be invalid to =
reduce
> > > code duplication?
> >=20
> > For two reasons:
> >=20
> > 1) the helper has no inteligence whatsoever. It just calls the same
> > functions.
> >=20
> > 2) the duplication will vanish whenever someone implements
> > ->runtime_idle() and have that call pm_runtime_autosuspend() (like PCI
> > and USB buses are doing today). This will just be yet another line that
> > needs to change.
> >=20
> > Frankly though, no strong feelings, I just think it's a commit that
> > doesn't bring that any benefits other than looking like one line was
> > removed.
> and yes that is what it tries to do nothing more nothing less. If in futu=
re
> there are no users (today we have quite a few), then we can remove the de=
ad
> macro, no harm. But that is not the situation today.

as I said, a commit that's bound to be useless. It's not like you're
saving 10 lines of code, it's only one. Replacing two simple lines with
a function which takes <joke> almost as many characters to type </joke>.

IMO, this is pretty useless and I'd rather not see them in the drivers I
maintain, sorry.

cheers

--=20
balbi

--pZs/OQEoSSbxGlYw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUJCUIAAoJEIaOsuA1yqRE4sQQAKxfridt97ire3OQknEdDVFu
aTPlvAJ0ycYXCy5Y9YI2w/jPYTkr+pOjpqCQc/lm0UssHhABkVAByhQPdZt/9O6F
H2/7BhzyUAw6aUE9uFd/CYi7ngfRRBdGgxHW0jEKtywEu6Y918ezt1ZXwdyXGBCx
NTP1sthcYPMCh5CShU+U5WaODAgeoeQa0iOLJ1lcn6wH9h/VyktzyvO8jYxcxPZ4
uiYe41oJAQCSQYSTZpWXMVGX4XF/tqs1gkVLSUgXctg0ANrxqP+HmQtUTMRw6ofP
4uj9feVcRmHficyJErFkQWJgblli8YUJsqhyCgeTIIQJCJ+99zrRidgXyJLBJAZX
4vD6U6+eo27mhj0o7Qc7xuWV/7pvud8FiojotM0SLSP1mOoS3oGEXWxT9K9eFmmT
cFaF4EJQPGY57tJvN003ijdICrJOLoDxxmV66MxmtqJ4n7pyJg5OikrxdpKMK7Gn
A6glrWgmNe7qZ9NxG8ITLNESTA6Svaj4FVpjet8lvDbVLEJUjCAMHZanoPIm8i81
ORgtJTYtTJKAN0SMi/dubKv8LCeP0JEdQ0wuGN8UEKmN3ImoEs422yF5LExdNn0L
WJ712CFagm6iYJVmaRdy+BCzJtlola/XiVdzJRRCfAkcGXpDW6Hkw/lUNcAQcfzP
JiOMpqscwF/mFSsPsvI0
=q0tM
-----END PGP SIGNATURE-----

--pZs/OQEoSSbxGlYw--

--===============0473778243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============0473778243==--
