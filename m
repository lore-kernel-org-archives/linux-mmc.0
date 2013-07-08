From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/3] mmc: omap_hsmmc: Enable SDIO IRQ using a GPIO in
 idle mode.
Date: Mon, 8 Jul 2013 10:50:27 +0300
Message-ID: <20130708075006.GE16635@arwen.pp.htv.fi>
References: <1365770307-19859-1-git-send-email-andreas.fenkart@streamunlimited.com>
 <1365770307-19859-2-git-send-email-andreas.fenkart@streamunlimited.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6403174971933409514=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1365770307-19859-2-git-send-email-andreas.fenkart-6oiIBCxl0MMjD8S081q9vkEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Andreas Fenkart <andreas.fenkart-6oiIBCxl0MMjD8S081q9vkEOCMrvLtNR@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

--===============6403174971933409514==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+jhVVhN62yS6hEJ8"
Content-Disposition: inline

--+jhVVhN62yS6hEJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 12, 2013 at 02:38:25PM +0200, Andreas Fenkart wrote:
> Without functional clock the omap_hsmmc module can't forward
> SDIO IRQs to the system. This patch reconfigures dat1 line as a
> gpio while the fclk is off. It uses regulare SDIO IRQ detection of
> the module, while fclk is present.
>=20
> Reviewed-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Signed-off-by: Andreas Fenkart <andreas.fenkart-6oiIBCxl0MMjD8S081q9vkEOCMrvLtNR@public.gmane.org>

looks like this patch needs to be split. In part one you add the normal
CIRQ handling and enable_sdio_irq() callback while in part two you add
the workaround handling for the missing swakeup line.

Another thing, just to make things clearer, I would require a quirk flag
(not only passing the gpio number) to enable the remuxing of the DAT1
line. And yet another thing, it should be clear in the commit log that
for devices which actually provide the swakeup line, setting the wakeup
bit for the DAT lines should be sufficient. That would mean OMAP devices
need to provide the 'idle' pinctrl state.

--=20
balbi

--+jhVVhN62yS6hEJ8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR2m9DAAoJEIaOsuA1yqRE6GgP/j2i5mLXmEBqvSAPo9gOosNj
xDlP/zokcNJknGdNSYGVsTZW6GizRXFyujfvOUxcTTLsyo/ghfZoJ1p6yWLKiV3b
Utxf1QLZEupGWz5tR3E0urMRbdpGRMPxUD/ixy7qYSG7KJu90keAsMyGXr52QK3j
JWEsdFVjDYb/nFhX/gGMneN/KSXyQotGuDU3me6rClH8d1ELle8s+2F19X+tLKbS
ViRGN1bXHPzpgWvHitXQYsJTnh64Gh2ELqK1DgRiUam6PLtHmFAlp4Pc3PFRCtjs
VyM70HdyXVHUtcVV7AZU5Ye0B2XzVJaFkuzb5Ad+sHT8D0BFQ+2hbwL3EWuAzSJ7
xy/+J1S/JCwlyaGg9G2w1SFfPuJdd4IkrQGYON9TOgxQw5/r/x20QXgiuWS0QHCT
0PfpfCKx1RWROHb3pMs7cT1/E3bP5cBTa8nyQauI9E0G4LZTBefTMF4aXuaSaXdS
yj76/+C39CwUzDZs6G3HLB56zJTe94yMrI+XEH7p9d/Zn7UCagWZh7vrL5ZeRWhv
61KYMzqUdIj8gfnDw18KLsObaWmDkm8KG/1GG46TYByIClNFvBbwaPgBXgVoEMsI
axq08dsLzuGpBwU1xNxOPWvOYKgW1LyrBIVsKlB8MSGHPp01QrRQrdLw4ZfIOneC
MgDoBg4m+zdSpSu+jOID
=RpSF
-----END PGP SIGNATURE-----

--+jhVVhN62yS6hEJ8--

--===============6403174971933409514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============6403174971933409514==--
