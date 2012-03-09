From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 0/4] mmc: sdhci-s3c: use the sdhci-pltfm.c and move
 the header file
Date: Fri, 9 Mar 2012 11:48:49 +0000
Message-ID: <20120309114845.GB3273@opensource.wolfsonmicro.com>
References: <4F55ABF0.1060801@samsung.com>
 <20120306130054.GA9890@sirena.org.uk>
 <201203061415.18836.heiko@sntech.de>
 <CAELcNGS6UynrJPRk1KtEJT3Rm6Jb5_scLm4KKca+dJ1ZYDOVbg@mail.gmail.com>
 <20120306163052.GX19635@opensource.wolfsonmicro.com>
 <4F56D003.5070406@samsung.com>
 <20120307184843.GW3107@opensource.wolfsonmicro.com>
 <4F584539.9080007@samsung.com>
 <20120308110105.GD3638@opensource.wolfsonmicro.com>
 <4F596296.60103@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F596296.60103@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, kgene kim <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 09, 2012 at 10:53:26AM +0900, Jaehoon Chung wrote:
> On 03/08/2012 08:01 PM, Mark Brown wrote:

> > It should be fine, like I say I didn't really read the patches in enough
> > detail as the diffstat set off alarm bells.

> If you have any opinions, let me know.
> I believe that these patches can be maintain more efficiently for eMMC

Like I said I think it's fine.  If it helps:

Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWe4XAAoJEBus8iNuMP3dNUsQAITRTIIxMgO+PROjUoitvSr6
axUynjZpRwt4Hm0/XYx2ZyqwtB0dObXe2xvjHCchnl/1HdeN8NH+0uTuWYeOB8tt
tLKYRANqZAidf84CwLOxtOADOts6IlnlAn6KE60dYQ+5hJv4SbGaaLqDSkFHxB1l
ZPvtzMjH6sS/rK0QXaxuEE2V+ru7tN0xsvV6l5/k1nXD+R5Ni1IwxCUfu+QXqUzD
vWMMXiVypXp1CfELntIL5aNf6lUUW1m3qNNXJ7/79b7R7/T0DqShSeVHiifMm+pS
jf/ns4+Y4YhFUghk47KyR8hDErOOc7KaMN7BVancQhTKc6iovVqpb+0NRlftSgSO
u683LMMUMuBuHOFF6ehh3YMxfghO4qmxQkBgxRXI5e3nUmJ/atZjtdwFQuRS+clI
VkAiFLUXu8KOCw1HgG1GlhC25gTfHD4vUzT+wcCb3h9t6TLiEYbS9Vpdx0Dbb6Wg
oWLBgAnkTmF3uERs08nhD/fOJFRgSuGD0zdT9kqzqezM4W6qBSEuudV7YqClHqXw
dEp3o1nrIET7u7TYJb3vYD+vOf7tLMXweRNjTn24BK81Zcpo/FimcWReI8g/KAas
KZfefALTePVUQxmFcrinkWQb4WIUXCO6FoCNPgI+8XHDpwU0UtGANkjHTxgj+74B
2vKMIRf487f0GmkGTi7l
=PTNl
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
