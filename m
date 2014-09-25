From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 00/27] add
	pm_runtime_last_busy_and_autosuspend() helper
Date: Thu, 25 Sep 2014 16:27:58 +0200
Message-ID: <20140925142758.GB1316@katana>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
 <6374313.I12loOK9hA@vostro.rjw.lan>
 <20140924201558.GX17997@saruman>
 <2322320.9rETJijE2n@vostro.rjw.lan>
 <20140924203219.GZ17997@saruman> <20140925075718.GW24663@intel.com>
 <20140925142201.GD28045@saruman>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0697962180=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20140925142201.GD28045@saruman>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Felipe Balbi <balbi@ti.com>
Cc: linux-wireless@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, patches@opensource.wolfsonmicro.com, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Chris Ball <chris@printf.net>, dri-devel@lists.freedesktop.org, Marcin Wojtas <mw@semihalf.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Herrmann <dh.herrmann@gmail.com>, Shinya Kuribayashi <skuribay@pobox.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Vinod Koul <vinod.koul@intel.com>, Jingoo Han <jg1.han@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Jani Nikula <jani.nikula@intel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Alan Stern <stern@rowland.harvard.edu>, Ben Skeggs <bskeggs@redhat.com>, Bjorn Andersson <bjorn.andersson@sonymobile.>
List-Id: linux-mmc@vger.kernel.org


--===============0697962180==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 09:22:01AM -0500, Felipe Balbi wrote:
> On Thu, Sep 25, 2014 at 01:27:18PM +0530, Vinod Koul wrote:
> > On Wed, Sep 24, 2014 at 03:32:19PM -0500, Felipe Balbi wrote:
> > > > > > OK, I guess this is as good as it gets.
> > > > > >=20
> > > > > > What tree would you like it go through?
> > > > >=20
> > > > > Do we really need this new helper ? I mean, the very moment when =
we
> > > > > decide to implement ->runtime_idle() we will need to get rid of t=
his
> > > > > change. I wonder if it's really valid...
> > > >=20
> > > > I'm not sure I'm following?  This seems to simply implement what dr=
ivers
> > > > have been doing already as one function.  Why would it be invalid t=
o reduce
> > > > code duplication?
> > >=20
> > > For two reasons:
> > >=20
> > > 1) the helper has no inteligence whatsoever. It just calls the same
> > > functions.
> > >=20
> > > 2) the duplication will vanish whenever someone implements
> > > ->runtime_idle() and have that call pm_runtime_autosuspend() (like PCI
> > > and USB buses are doing today). This will just be yet another line th=
at
> > > needs to change.
> > >=20
> > > Frankly though, no strong feelings, I just think it's a commit that
> > > doesn't bring that any benefits other than looking like one line was
> > > removed.
> > and yes that is what it tries to do nothing more nothing less. If in fu=
ture
> > there are no users (today we have quite a few), then we can remove the =
dead
> > macro, no harm. But that is not the situation today.
>=20
> as I said, a commit that's bound to be useless. It's not like you're
> saving 10 lines of code, it's only one. Replacing two simple lines with
> a function which takes <joke> almost as many characters to type </joke>.
>=20
> IMO, this is pretty useless and I'd rather not see them in the drivers I
> maintain, sorry.

It is not a NACK from me; yet from a high-level perspective I agree with
Felipe.


--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUJCZuAAoJEBQN5MwUoCm2jzAP/0uNlfLXi5fqmFvgh5egMX44
Awl2fFUmc3+ZEwe23znHmWxWFQwxjpwRaGlXN2yVwhPZfvYZE4RCAGIGNrqzpZSv
qzqeYbcNa3os06IQQ0x2CSsB27ay5QJsqomMrmeU5qBXlZI9c6AlxKLFubkIKXgV
mtwD415hSXBv4oAsbJvwV7zDvWPkvwmy+sircUTem/aXH1YlmkOQYAkskBxbE456
5/b+4IlyaVbnNzYT/TmHfH5Gk0uCvd5EOG00up8itDUQyjbXbRsMRvyZj5KPCFvP
QCitjmxtnTvqNgoT997fAzBvkW/RoooTajOynTNwD5bo150g5vMDqzPhdDRpe+H8
xplm3ukStUlouRYM3IcOSyAP6ngx464UiJ+6df189XTe58y8Vy1uvwY9sniUkH4/
HjVG2XfwVewxy7WXtOqQEC+SBqAWYIe/J+L+GLNyvETyDV5blHWQKBwbhXIhNBFZ
2JFDp8dJx/798USWsMmKMA1Rx8B52aO8xNVC1qxqom1Ua+EfnUs8rzGToTKK0iyW
e8ZgwBDKgDIFLk160zldynIyFLuJepA/jjQHUUdO16YEe2gGHi/Pz6axA9v68A8l
GgrR9I5vUBxFvELY4d8UH6zknXVgpKMNheRza9EUy6AxsYzAeFD6TLfUOdun1M6I
Vogk8ikO5me6suf8bPAj
=9gUi
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--

--===============0697962180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============0697962180==--
