From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] regulator: core.c Pass voltage to notifier when
 setting voltage
Date: Fri, 15 Jun 2012 19:08:12 +0100
Message-ID: <20120615180812.GA18638@opensource.wolfsonmicro.com>
References: <1339711609-3417-1-git-send-email-prakity@marvell.com>
 <CADTbHxq5rmHJtFTp53sYhFSYWVrSqyo_Jq+0aWNOF2HQR+nhGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CADTbHxq5rmHJtFTp53sYhFSYWVrSqyo_Jq+0aWNOF2HQR+nhGA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pankaj Jangra <jangra.pankaj9@gmail.com>
Cc: Philip Rakity <philipspatches@gmail.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>
List-Id: linux-mmc@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 15, 2012 at 11:28:38PM +0530, Pankaj Jangra wrote:

> I am also curious to know if you pass the  voltage here to notifier call
> how does it make any difference, since in
> blocking_notifier_call_chain() again passes the NULL. So does your patch
> should  modify the arguments to this function also?
> Please let me know if i am missing something in understanding.

Your mail would have been rather more comprehensible if you'd mentioned
that you were talking about the call in _blocking_notifier_call_chain()
(which is obviously buggy).

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP23oEAAoJEBus8iNuMP3dHmcP/31GlpNhrk696wzg0qinfC6F
e8FXFdfPdAHn5GJmKXUf4MS7WHpX4yLqqx/u37NCOn8r8pGN+3BP6bXimgykrgAc
NvvmNfQKfzpp4tkvjsD4khArCVRXom1qldIepiBbSCnDPjDdqz/UJxN9h1vqQqsn
ZDXkC3TyQHOIt2C42iL5r0RKGzgew44GI+XZH8pVtul+6sOHQemsz8/qQVLDArKc
tcGyDakeDwjzrRWdIpPVo/oT5CKnfnNFZRWBk2ZYmUF0OQGHX2dKHabz62UqQk6r
YdvUIvdEfO6anTdK9NcyFok/WpEizRzUE5HeVSUvAqDGLoeU2VLqXxosiBxXrU81
aRSwfnn+dmbvevnF4uME+3aPklSszVI23WXcezn/XDPDYZw8TNOIXwJrqbBYlCis
a2SLGmBWqfYE7ufhhlt5yLn41wZG1Ut7hKip1V2s52VKRXBTGdtCz66yKkRPbk5v
0ohL4tFfwn6J5chul9cll82xaxmTetkqvr0k3BK8OjJ47XzSr/RRoVvePf6PR/s+
FtwJ5klL1G3fVVyvvtnHAlsh6S31gO4E/L7N/d5VSSoWMY8gbcHUisvNj8/HnWkC
qtpSXbI4TvgOwCyh2Wv1YStdhimrC6R2Ov3eexL1t8iCsPIa4STEidRyaw2C4azT
hEx/YrpX6kKQ9Vxw2QX+
=wRLx
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
