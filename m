Received: from list.virtualsheetmusic.com (list.virtualsheetmusic.com [170.249.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3460145323
	for <linux-mmc@vger.kernel.org>; Thu, 11 Apr 2024 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.249.201.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833034; cv=none; b=FwCCYWZmlGr0oU171TlRNRn/aB1HDAhiJMkgpTS8SitUlvgIdtFDqyW9nuOhvWgxDdSm15rc7mSYe4bclGGy5xzTrSMkSfnaWbLidGLbmBn+gQJ94ZLn5Go/s0BVUwYzSOwrL8nPSfTyddDWhESonvX0fpG5mzeV2JxwOPh6xp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833034; c=relaxed/simple;
	bh=6/CZ8Td3ZUruKgLNYjKXVkztppdTkKraFPNdni3InJM=;
	h=To:Subject:MIME-Version:From:Content-Type:Message-Id:Date; b=Ls/EGRJD+fgBbWG9PENBd/3ELC1sxH0xgiHp79is3RXjsDc9aoHpMbKfFzwU673iErwj0AhvS+GbbfCfO2g/BzetWo2EOWjMt7w/bdZ/a7JM25nGn6BYZ5h7he/4k4cE4ff+J4bIYeiViBDp5cedc0QX/tLLLaxxT170x/LD+dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=musicianspage.com; spf=pass smtp.mailfrom=musicianspage.com; dkim=pass (1024-bit key) header.d=list.virtualsheetmusic.com header.i=@list.virtualsheetmusic.com header.b=BQ3H6tES; arc=none smtp.client-ip=170.249.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=musicianspage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=musicianspage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=list.virtualsheetmusic.com header.i=@list.virtualsheetmusic.com header.b="BQ3H6tES"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=list.virtualsheetmusic.com; s=y; h=Date:Message-Id:
	Content-Transfer-Encoding:Content-Type:Reply-To:From:MIME-Version:Subject:To:
	Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=hxg146BoDHN9rzFx0bQm/j7hNvlqBnDeZUJYywUsNBQ=; b=BQ3H6tESr1GG
	I3bFa22nrdnyZDss1kKFt/TiILCxtNBWbUVrzSOA77ZCvxBT7b9an3GrqFRMo8CnUuUbHPQ/f9Fc8
	7/ns5ZfJ/YNwGo2A3iq+afCJrQwg3spoJUQ5vJnKkyQVTbo476DXDld33nNJPwWEw7T7Sw04GoLIg
	/xmxM=;
Received: from root by list.virtualsheetmusic.com with local (Exim 4.92)
	(envelope-from <no-reply@musicianspage.com>)
	id 1rus76-0001Ui-IT
	for linux-mmc@vger.kernel.org; Thu, 11 Apr 2024 03:57:04 -0700
To: linux-mmc@vger.kernel.org
Subject: Music News and Site Updates (April 11, 2024)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Musicians Page <newsletter@musicianspage.com>
Reply-To: Musicians Page <newsletter@musicianspage.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Message-Id: <E1rus76-0001Ui-IT@list.virtualsheetmusic.com>
Date: Thu, 11 Apr 2024 03:57:04 -0700

Dear Musician and Music Lover,

Here is the Newsletter from Musicians Page website:

http://www.musicianspage.com

As you have requested. Read on...

(If you are no longer interested in subscribing to this newsletter, you can=
 unsubscribe by clicking the link at the bottom of this newsletter. Thanks!=
)




---------------------------------------------------------------------------=
-

If you are not yet registered as a Musician or Band/Ensemble, be sure to si=
gn-up from the following page (it's free!):

https://www.musicianspage.com/signup.php?email=3Dlinux-mmc@vger.kernel.org

---------------------------------------------------------------------------=
-




Consider to join with a Standard or Pro Membership
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Either if you are a Musician or a Music Employer, have a look at our Member=
ship Plans and sign up for the one that best fits your needs:


http://www.musicianspage.com/membership.html


A Standard or Pro Membership gives you the ability to upload unlimited audi=
o, video, and sheet music files to your profile; as well as a more complete=
 resume (or service/company info if you are an employer) and a creative pag=
e with media content. If you are a musician, you will also have the chance =
to get featured on the new Musicians Page radio:

http://www.musicianspage.com/music/radio/


Musicians Page gives you a professional space on the web to showcase your t=
alent to potential employers or, for employers, to have a professional and =
targeted space on the web where to showcase your products or services to po=
tential prospects. Musicians Page gives you the chance to differentiate you=
rself from other musicians or the competition who only use amateur channels=
 such as MySpace, FaceBook, YouTube, or other free sites.

Also, do you know that your profile on Musicians Page is Google optimized?

This means that employers, other musicians or prospects can easily find you=
 via Google. Our system automatically optimizes every Musician's profile to=
 appear at the top of Google results for relevant keywords. Just another re=
ason to take full advantage of all that the Standard and Pro Memberships ha=
ve to offer, and not rely solely on free social networks that won't optimiz=
e your profile for others to see at the top of the list!

With a Standard or Pro Membership, you'll also be able to find and apply fo=
r external jobs Musicians Page finds for you on the web (if you are a music=
ian) and, with a Pro Membership, be notified via email as soon as a new ext=
ernal jobs, matching your profile, are found. Or, if you are an employer, b=
e featured prominently on any webpage of our site to over 2,000 unique user=
s daily.

Musicians Page is a network for professional musicians and music employers,=
 built and planned to grow based on professional musicians' and music emplo=
yers' needs. Don't miss the opportunity to jump on the band wagon from the =
beginning.

Membership fees are likely to be increased in the coming weeks, so join Mus=
icians Page today and start networking the right way!

https://www.musicianspage.com/signup.php




Are you looking for musicians, a song writer, a lyricist, a composer?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If so, please post your music job or project on Musicians Page.
To post a job/project is completely free and takes 5 minutes:

http://www.musicianspage.com/login/panel.php?yourjobs=3D1&postnew=3D1


REMEMBER: you can post a job even for a FREE project you need musicians for=
!




Latest Posted Jobs on Musicians Page
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Trio or Quartet for  Sihanoukville
http://www.musicianspage.com/jobs/7730/

Hammond B3 Organ Player
http://www.musicianspage.com/jobs/7729/

Guitarist Wanted
http://www.musicianspage.com/jobs/7728/

New Woodwind orchestra
http://www.musicianspage.com/jobs/7727/

Female singer,rapper to Collab Remotely
http://www.musicianspage.com/jobs/7724/

Music Duo
http://www.musicianspage.com/jobs/7721/

Guitarist needed in Mexico for rock and roll music
http://www.musicianspage.com/jobs/7720/

STEEL PAN SOLOIST FOR CRUISE SHIPS URGENT
http://www.musicianspage.com/jobs/7715/

Lauren Daigle Cover Singer
http://www.musicianspage.com/jobs/7716/

Violinist Wanted
http://www.musicianspage.com/jobs/7717/


More jobs:
http://www.musicianspage.com/jobs/




Latest External Jobs or Opportunities (found on the web)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Metal guitarist looking to join or form band
http://www.musicianspage.com/extjobs/1267624/

Looking for a female vocalist
http://www.musicianspage.com/extjobs/1267623/

Seeking Funk/R&amp;B Male Vocalist
http://www.musicianspage.com/extjobs/1267622/

Guitarist/Keys/Banjo player 67 yrs old looking for jam band blues country r=
ock
http://www.musicianspage.com/extjobs/1267621/

Guitarist looking for metal drummer and/or other musicians.
http://www.musicianspage.com/extjobs/1267620/

Guitar needed in the Vein of Failure/HUM/Quicksand Shoegaze, Post HC
http://www.musicianspage.com/extjobs/1267619/

Looking for bassist and drummer!
http://www.musicianspage.com/extjobs/1267618/

GUITARIST WANTED FOR METALCORE/POST-HXC PROJECT
http://www.musicianspage.com/extjobs/1267617/

Drummer Wanted For Original Metal/Industrial/%%@!
http://www.musicianspage.com/extjobs/1267616/

Looking for guitarist for PRO Metal band
http://www.musicianspage.com/extjobs/1267615/


More jobs:
http://www.musicianspage.com/jobs/




Latest Forum Topics
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Joe Hisaishi-You&#039;re in Love(Howl&#039;s Moving Castle OST), Piano - by=
 Luis Afonso Andre
posted on the Soundtrack/Film Music forum
http://www.musicianspage.com/forums/music/soundtrack/9047/


William Baulch - Glissaccatura, Guitar (Grade 4) - by Luis Afonso Andre
posted on the Classical Music forum
http://www.musicianspage.com/forums/music/classicalmusic/9046/


New Release - by KonstantinDobriak
posted on the General Forum forum
http://www.musicianspage.com/forums/general/general/9045/


More forum topics:
http://www.musicianspage.com/forums/




Latest Uploaded Audio Files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

While There&#039;s Still time by Jeremiah Minahan (added by Jeremiah Minaha=
n)
Genre: Christian
http://www.musicianspage.com/musicians/54000/audiofile/22980/


You Are The Blessed by Jeremiah Minahan (added by Jeremiah Minahan)
Genre: Christian
http://www.musicianspage.com/musicians/54000/audiofile/22979/


Read The Book by Jeremiah Minahan (added by Jeremiah Minahan)
Genre: Christian
http://www.musicianspage.com/musicians/54000/audiofile/22978/


More audio files:
http://www.musicianspage.com/audio/


We are waiting for your comments and if you have any, please upload your
own audio files from the page below (you must register first):

https://www.musicianspage.com/login/panel.php?addaudiofiles=3D1




Latest Uploaded Video Files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Limehouse Blues by mikewarmblood (added by Thomas Jacques)
Genre: Classical/Contemporary
http://www.musicianspage.com/musicians/53997/videofile/21230/


Mr Sandman by mikewarmblood (added by Thomas Jacques)
Genre: Classical/Contemporary
http://www.musicianspage.com/musicians/53997/videofile/21229/


symphonic Orchestra.. by George G (added by Greg Rangel)
Genre: Classical/Contemporary
http://www.musicianspage.com/musicians/53990/videofile/21228/


More video files:
http://www.musicianspage.com/video/


We are waiting for your comments and if you have any, please upload your
own video files from the page below (you must register first):

https://www.musicianspage.com/login/panel.php?addvideofiles=3D1




Latest Uploaded Sheet Music Files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Along the Danube by Joe Sinha Semple (added by Joe Sinha Semple)
Genre: Classical/Contemporary
http://www.musicianspage.com/musicians/53961/sheetmusic/3286/


Respighi. Vetrate di Chiesa. Parts by Ottorino Respighi (added by Grechaniv=
sky)
Genre: Classical/Contemporary
http://www.musicianspage.com/musicians/9640/sheetmusic/3282/


XLIII Memoriam Vivere by Marisol Jimenez (added by Marisol Jimenez)
Genre: Contemporary
http://www.musicianspage.com/musicians/11620/sheetmusic/3278/


More sheet music files:
http://www.musicianspage.com/sheetmusic/


We are waiting for your comments and if you have any, please upload your
own sheet music files from the page below (you must register first):

https://www.musicianspage.com/login/panel.php?addsheetmusic=3D1




Earn money with your website, FaceBook, YouTube or MySpace
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you own a website or simply an account on FaceBook, YouTube, MySpace or =
Twitter, be sure to check out the Virtual Sheet Music's Affiliate Program w=
hich entitles you to earn 30% commission on any referred sale.

It is completely free to join:

https://affiliates.virtualsheetmusic.com/


and once you have an account, start referring users using a special code to=
 put on your website or social account (FaceBook, Twitter, etc).

For any further questions, please reply to this email, we will be glad to h=
elp you step by step.




Join us on the major Social Networks
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Stay updated with our latest news on:

1. on FaceBook:
http://www.facebook.com/MusiciansPage

2. on Twitter:
http://twitter.com/MusiciansPage




---------------------------------------------------------------------------=
-----

FEATURE YOURSELF ON MUSICIANS PAGE:
=20
If you have an upcoming concert, CD release, special Event, or just want to=
 promote yourself and your activity, remember you can feature yourself in f=
ront of thousands of musicians, music lovers, and music employers (includin=
g music agents, artist management companies, etc.) by exclusively putting y=
our picture and name on every page of Musicians Page, starting at just $10 =
(that's right, just 10 bucks!):
=20
https://www.musicianspage.com/login/panel.php?featureyourself=3D1
=20
Your ad will be displayed exclusively for the duration of your campaign, gi=
ving you maximum exposure to the Musicians Page community. Musicians Page i=
s visited by thousands of musicians and people working in the music busines=
s every day, so consider putting yourself in front of this specialized audi=
ence.

This is your chance to make new contacts and seize exciting opportunities i=
n minutes! Don't miss this opportunity now!

---------------------------------------------------------------------------=
-----




Please feel free to pass this Newsletter along to friends and other musicia=
ns who might find this content valuable in the same way you do, and be sure=
 to send us your ideas and thoughts by either replying to this email or by =
posting your comments and feedback on the dedicated forum below:

http://www.musicianspage.com/forums/general/feedback/

Thank you!

All the best,
Fabrizio Ferrari, CEO
Musicians Page
http://www.musicianspage.com
Virtual Sheet Music Inc.
http://www.virtualsheetmusic.com
29911 Niguel Road, #6992
Laguna Niguel, CA 92677 (USA)
Fax: +1 800 717 1876 or +1 973 273 2171
----------------------------------------------
This message was sent from Musicians Page
http://www.musicianspage.com
To unsubscribe, please go to:
http://www.musicianspage.com/unsubscribe.php?email=3Dlinux-mmc@vger.kernel=
=2Eorg
