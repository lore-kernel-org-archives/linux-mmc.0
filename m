Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EF51B47D7
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 20:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718914174; cv=none; b=k3cBBaCt+cx4vCTBRHBnxXaNIL6wpMIl2nfL7FEaRzZyeoMi42m1c9OVRuDyrq8a3qO68Jct2QYsEMbq6hpv1kI7WdeSGtA8rBylhhlRTncKcDYwFzmg5WAK/1bnAEkB5fLj2tEb8b5Tpz9khZDqe7PcO7C5xicikZb8tLk0GKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718914174; c=relaxed/simple;
	bh=QpveN4iN7L13q0sJ+8sxHrE/oNMaO6mMAqrJT6R8M2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thYIzgArSutiJfaOeFFJMKiQTTSdo94k/kjb91l9ZftCJpwdad52/z06ZTesGacxFT3NfrCPyGH2yAkfmw0i2hiFnZOmQldYhxAPX2nF8HO73/yeRK9v2Sw7JZsqLcIesdiiz3SgOIpKnJey2bpK2mOk0fyGX32DT0bcP70C4xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=QY1Mh9fK; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="QY1Mh9fK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Qpve
	N4iN7L13q0sJ+8sxHrE/oNMaO6mMAqrJT6R8M2c=; b=QY1Mh9fK2gylUJ+oQKvX
	xW67K4YaVWmKkNC9/yn6/o/EDIsn/+MPLVS7KxZuGA9zyl3SBy4/WRFi8+iUaKbd
	zmSZFq31NisK1nTawF9GEhyekAP1aFLNBNkYWQgKvXi1S71Zcmcs8jYCQFwOp7aJ
	ZwqChlffgGsO9uzsfG6UwD6OqsOWRUxG9e/jlJquAbrtOTptu82nEnWtQObO097v
	EvgYunKdbMQkCkeq0lAz/cbjuGb1ceApKadvNXdQE6veuWsrkLerDqDhi24hFNY9
	6oYHoQPFqiz7N4KEtx5nXeHjDU9hsA0tE8g3idTnCNtU6rVE0yN72p0hZ8X/22Pi
	Jw==
Received: (qmail 1135263 invoked from network); 20 Jun 2024 22:09:29 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Jun 2024 22:09:29 +0200
X-UD-Smtp-Session: l3s3148p1@czZx5FcbNJdehh9j
Date: Thu, 20 Jun 2024 22:09:28 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: tmio: Remove obsolete .set_pwr() callback()
Message-ID: <dyhcjodncsmeufbsjbn2okj2wnjihohzzcoqfbmbxqjquc4hof@5lk7w6ihm56z>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <cover.1718897545.git.geert+renesas@glider.be>
 <fbbc13ddd19df2c40933ffa3b82fb14841bf1d4c.1718897545.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="up77gtjpgaw7xcqk"
Content-Disposition: inline
In-Reply-To: <fbbc13ddd19df2c40933ffa3b82fb14841bf1d4c.1718897545.git.geert+renesas@glider.be>


--up77gtjpgaw7xcqk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 05:39:46PM GMT, Geert Uytterhoeven wrote:
> Commit ca78476e4888f1f1 ("mfd: Remove toshiba tmio drivers") removed the
> last users of the .set_pwr() callback in the tmio_mmc_data structure.
> Remove the callback, and all related infrastructure.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Cool, I had the gut feeling that more cleanups were possible after the
plain TMIO drivers were removed.


--up77gtjpgaw7xcqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZ0jHgACgkQFA3kzBSg
KbYSaA/9FO/lBWoRo3w6JYT06UwJek+wuufUKHBM6HUkkQOFk/xOfawWjUsa1CBw
93BzAS6YgUZXXQ6mcUSRxznfNC+WSwKpkxgoUPc6e/fJ6X+CIG55RNkDmsUH86W6
BwTiX/JbCS/RWspPpgrHHz3RNdgPRrBswWQCpl9MsZ2dd9mOeUIedEzd2Z1O4l+V
Ek8e6ReYwGWIdKuogjABu8RYizSb5ARjfsfKPvggbqu8rgykl0Ugg9ZZABjvwHmK
6Jq4W+ay5qFtFQ/SQTZQXtE8V5pV+ys0kApCJdYFY1xAbbEMT9/Cu9O/Jj4fJWLW
0A09DEAHc7Xpdo/dSvrXnRwa7BsSBeAKIp2aihNIfXijHaTRhjwcGTAaQEGVXLuJ
UBwzatq1wKbNRmR2h8KsTojFdyCDmSHp9mn3/OrAXfaVGqM1jVZicX4mI5U5u/Vm
XNtBLYXiLRxUGspW9OziLLoadHken1tVuSa+YPsbvNnMeEEpWuFd03FMdKjAX6lA
HhFgPEjW8Ui1HzfVphpP5mB5b9kFdQChD56XtdHJufXZ9T7gJ0eMvpR0nru5NNX/
ntCfLQKggOtVtJbpYgcQp+jgxhXYFkHURU0iUAoz5AYFw2L8xSpAjg5+Pm9yuymL
W3QB1gz99Da2Z/E1YgXc5U5BsxvwcgbLdJLfR2B0Wsgc4zY1VDs=
=miqW
-----END PGP SIGNATURE-----

--up77gtjpgaw7xcqk--
