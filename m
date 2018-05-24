From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 08/13] ASoC: pxa: remove the dmaengine
	compat need
Date: Thu, 24 May 2018 14:58:36 +0100
Message-ID: <20180524135836.GR4828@sirena.org.uk>
References: <20180524070703.11901-1-robert.jarzmik@free.fr>
 <20180524070703.11901-9-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7081102325017339701=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180524070703.11901-9-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org, Richard Weinberger <richard@nod.at>, linux-mmc@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, netdev@vger.kernel.org, dmaengine@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Daniel Mack <daniel@zonque.org>, linux-media@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--===============7081102325017339701==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="brdEIFGMNIjz5YJG"
Content-Disposition: inline


--brdEIFGMNIjz5YJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 24, 2018 at 09:06:58AM +0200, Robert Jarzmik wrote:
> As the pxa architecture switched towards the dmaengine slave map, the
> old compatibility mechanism to acquire the dma requestor line number and
> priority are not needed anymore.

Acked-by: Mark Brown <broonie@kernel.org>

--brdEIFGMNIjz5YJG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsGxQsACgkQJNaLcl1U
h9AOOQf+ICndtAhAUcJYotu2F1wfe6zK/SmwQs2RaAzNMRnQTNmdgQDHaITOBSE0
juDyVbEzdIjDwHmu3lB6bZ+mj3MDpGeJ1DPvvi6aI+pkDH/J16XMXXTchXyo3NI0
db1lLlmXYiTbnsVGU2bO6hMCG588Us7ZyHzt2pxD0f9LqNzy3f617uD3fSQZSzrd
a5JyJZMHQfoIhO58gKX7fQ+JVum/7BFb2S4eFv/DZPZsU9Gy96h0viVcyImmE+ri
qS4cfZJlV/PC7m4GYIP8V23Dl6rj8wsh7YvKUUtat6tIqGRkZtHFEo6BCQedA3Ka
+7F7zfmpLYaC8VeKI0Fp8fxfDYF0Jg==
=gxiC
-----END PGP SIGNATURE-----

--brdEIFGMNIjz5YJG--

--===============7081102325017339701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7081102325017339701==--
